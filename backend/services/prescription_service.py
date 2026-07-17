"""处方业务服务：创建处方 + 剂量校验 + 触发自动审核"""
from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session

from models.herb import Herb
from models.prescription import Prescription
from schemas.prescription import PrescriptionCreate, PrescriptionOut
from services.review_service import run_auto_review


def validate_dosage(db: Session, herbs: List[Dict[str, Any]]) -> Dict[str, Any]:
    """
    剂量校验：检查每味药材的用量是否在安全范围内。

    参数:
        db: 数据库会话
        herbs: 处方药材列表，每项至少包含 {"id": int, "current_dosage": float}
               示例: [{"id": 1, "name": "甘草", "current_dosage": 3.0}]

    返回:
        {
            "warnings": [{ "herb_name", "message", "actual", "min", "max" }],
            "high_risks": [{ "herb_name", "message", "actual", "min", "max" }],
            "critical_risks": [{ "herb_name", "message", "actual", "min", "max" }],
            "has_critical": bool,   # 是否存在严重越界
            "score": int,           # 风险总分
        }
    """
    warnings: List[Dict[str, Any]] = []
    high_risks: List[Dict[str, Any]] = []
    critical_risks: List[Dict[str, Any]] = []
    score = 0

    # 批量查药材（避免 N+1）
    herb_ids = [h.get("id") for h in herbs if h.get("id")]
    herb_map: Dict[int, Herb] = {}
    if herb_ids:
        for h in db.query(Herb).filter(Herb.id.in_(herb_ids)).all():
            herb_map[h.id] = h

    for herb in herbs:
        herb_id = herb.get("id")
        name = herb.get("name", "未知")
        dosage = herb.get("current_dosage") or herb.get("dosage", 0)

        h = herb_map.get(herb_id)
        if not h:
            # 数据库中无此药材记录，跳过校验
            continue

        min_d = h.min_dosage or 0
        max_d = h.max_dosage or 999

        if dosage < min_d:
            warnings.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 低于最小剂量 ({min_d}g)",
                "type": "warning",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 1
        elif dosage > max_d * 1.5:
            critical_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 1.5 倍 ({max_d * 1.5}g)",
                "type": "critical",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 10
        elif dosage > max_d:
            high_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 ({max_d}g)",
                "type": "high",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 5

    return {
        "warnings": warnings,
        "high_risks": high_risks,
        "critical_risks": critical_risks,
        "has_critical": len(critical_risks) > 0,
        "score": score,
    }


def determine_risk_level(score: int, has_critical: bool) -> str:
    """根据风险分确定等级"""
    if has_critical or score > 10:
        return "high"
    if score > 5:
        return "medium"
    return "low"


def create_prescription_with_review(db: Session, payload: PrescriptionCreate) -> PrescriptionOut:
    """创建处方：持久化 + 剂量校验 + 自动审核"""
    herbs = payload.herbs or []

    # 1) 持久化处方
    rx = Prescription(
        visit_id=payload.visit_id,
        patient_id=payload.patient_id,
        diagnosis=payload.diagnosis,
        syndrome=payload.syndrome,
        herbs=herbs,
        notes=payload.notes,
    )
    db.add(rx)
    db.commit()
    db.refresh(rx)

    # 2) 剂量校验
    dosage_result = validate_dosage(db, herbs)

    # 将剂量校验结果写入处方
    rx.dosage_risk = len(dosage_result["high_risks"]) > 0 or dosage_result["has_critical"]
    rx.risk_score = dosage_result["score"]
    rx.risk_level = determine_risk_level(dosage_result["score"], dosage_result["has_critical"])

    all_risks: List[str] = []
    for w in dosage_result["warnings"]:
        all_risks.append(f"[warning] {w['message']}")
    for h in dosage_result["high_risks"]:
        all_risks.append(f"[high] {h['message']}")
    for c in dosage_result["critical_risks"]:
        all_risks.append(f"[critical] {c['message']}")
    rx.risks = all_risks

    db.commit()
    db.refresh(rx)

    # 3) 触发自动审核（配伍禁忌检测在 review_service 中完成）
    run_auto_review(db, rx)

    return rx
