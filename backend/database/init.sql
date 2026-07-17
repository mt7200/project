-- ============================================================
-- 中医医疗系统 - 数据库初始化脚本
-- 技术栈: MySQL 8.x InnoDB
-- 创建日期: 2026-07-16
-- 负责人: 李鮋
-- ============================================================

-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS tcm_hospital
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE tcm_hospital;

-- 2. sys_user — 系统用户表
CREATE TABLE sys_user (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    username        VARCHAR(50)  NOT NULL UNIQUE COMMENT '用户名',
    password_hash   TEXT         NOT NULL COMMENT '密码哈希值',
    role            VARCHAR(20)  DEFAULT 'doctor' COMMENT '角色：admin-管理员，doctor-医生',
    real_name       VARCHAR(50)  COMMENT '真实姓名',
    phone           VARCHAR(20)  COMMENT '联系电话',
    is_active       TINYINT      DEFAULT 1 COMMENT '是否启用：0-禁用，1-启用',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT '系统用户表';

-- 3. patient — 患者信息表
CREATE TABLE patient (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(50)  NOT NULL COMMENT '姓名',
    gender          VARCHAR(10)  COMMENT '性别：男/女',
    age             INT          COMMENT '年龄',
    phone           VARCHAR(20)  UNIQUE COMMENT '联系电话',
    id_card         VARCHAR(20)  UNIQUE COMMENT '身份证号',
    address         VARCHAR(200) COMMENT '住址',
    blood_type      VARCHAR(10)  COMMENT '血型',
    height          DECIMAL(4,1) COMMENT '身高 (cm)',
    weight          DECIMAL(5,1) COMMENT '体重 (kg)',
    allergy_info    TEXT         COMMENT '过敏史',
    status          VARCHAR(20)  DEFAULT 'active' COMMENT '状态：active-在院，discharged-出院',
    created_by      BIGINT       COMMENT '建档人 (sys_user.id)',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES sys_user(id)
) COMMENT '患者信息表';

-- 4. visit_record — 就诊记录表
CREATE TABLE visit_record (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    patient_id      BIGINT       NOT NULL COMMENT '患者 ID',
    doctor_id       BIGINT       NOT NULL COMMENT '主治医生 ID',
    visit_date      DATE         NOT NULL COMMENT '就诊日期',
    chief_complaint TEXT         COMMENT '主诉',
    present_illness TEXT         COMMENT '现病史',
    past_history    TEXT         COMMENT '既往史',
    allergy_history TEXT         COMMENT '过敏史',
    personal_history TEXT        COMMENT '个人史',
    tongue_image    TEXT         COMMENT '舌象照片路径/描述',
    pulse_image     TEXT         COMMENT '脉象照片/描述',
    other_exams     TEXT         COMMENT '其他检查',
    status          VARCHAR(20)  DEFAULT 'ongoing' COMMENT '状态：ongoing-进行中，completed-已完成',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (doctor_id)  REFERENCES sys_user(id),
    INDEX idx_patient_visit (patient_id, visit_date)
) COMMENT '就诊记录表';

-- 5. diagnosis_result — 辨证诊断结果表
CREATE TABLE diagnosis_result (
    id            BIGINT PRIMARY KEY AUTO_INCREMENT,
    visit_id      BIGINT       NOT NULL COMMENT '就诊记录 ID',
    pattern_name  VARCHAR(100) NOT NULL COMMENT '证型名称',
    pattern_code  VARCHAR(20)  COMMENT '证候编码',
    confidence    INT          COMMENT '置信度（0-100）',
    description   TEXT         COMMENT '证型描述',
    symptoms      TEXT         COMMENT '关键症状',
    etiology      VARCHAR(200) COMMENT '病因',
    pathogenesis  VARCHAR(200) COMMENT '病机',
    is_selected   TINYINT      DEFAULT 0 COMMENT '是否最终选定诊断',
    source        VARCHAR(20)  DEFAULT 'manual' COMMENT '来源',
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visit_record(id),
    INDEX idx_visit (visit_id)
) COMMENT '辨证诊断结果表';

-- 6. herb — 中药材表
CREATE TABLE herb (
    id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50)  NOT NULL UNIQUE COMMENT '药材名称',
    category    VARCHAR(50)  NOT NULL COMMENT '分类',
    nature      VARCHAR(20)  COMMENT '药性',
    taste       VARCHAR(20)  COMMENT '药味',
    meridian    VARCHAR(100) COMMENT '归经',
    min_dosage  DECIMAL(5,1) COMMENT '药典最小剂量',
    max_dosage  DECIMAL(5,1) COMMENT '药典最大剂量',
    unit        VARCHAR(5)   DEFAULT 'g' COMMENT '单位',
    is_toxic    TINYINT      DEFAULT 0 COMMENT '是否有毒',
    functions   TEXT         COMMENT '功效',
    indications TEXT         COMMENT '主治',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_nature (nature)
) COMMENT '中药材表';

-- 7. herb_incompatibility — 配伍禁忌关系表
CREATE TABLE herb_incompatibility (
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    herb_a_id  BIGINT      NOT NULL COMMENT '药材 A ID',
    herb_b_id  BIGINT      NOT NULL COMMENT '药材 B ID',
    type       VARCHAR(20) NOT NULL COMMENT '关系类型',
    detail     VARCHAR(200) COMMENT '详细说明',
    FOREIGN KEY (herb_a_id) REFERENCES herb(id),
    FOREIGN KEY (herb_b_id) REFERENCES herb(id),
    UNIQUE KEY uk_herb_pair (herb_a_id, herb_b_id, type)
) COMMENT '配伍禁忌关系表';

-- 8. formula — 方剂表
CREATE TABLE formula (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL UNIQUE COMMENT '方剂名称',
    category_l1     VARCHAR(50)  COMMENT '一级方剂类型',
    category_l2     VARCHAR(50)  COMMENT '二级方剂类型',
    functions       TEXT         COMMENT '功能',
    indications     TEXT         COMMENT '主治',
    modifications   TEXT         COMMENT '加减化裁',
    source          VARCHAR(200) COMMENT '来源',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT '方剂表';

-- 9. formula_herb — 方剂-药材关联表
CREATE TABLE formula_herb (
    id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    formula_id  BIGINT       NOT NULL COMMENT '方剂 ID',
    herb_id     BIGINT       NOT NULL COMMENT '药材 ID',
    dosage      VARCHAR(50)  COMMENT '用量描述',
    sort_order  INT          DEFAULT 0 COMMENT '排序',
    FOREIGN KEY (formula_id) REFERENCES formula(id),
    FOREIGN KEY (herb_id)    REFERENCES herb(id),
    UNIQUE KEY uk_formula_herb (formula_id, herb_id)
) COMMENT '方剂-药材关联表';

-- 10. prescription — 处方表
CREATE TABLE prescription (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    prescription_no VARCHAR(50)  UNIQUE COMMENT '处方编号',
    patient_id      BIGINT       NOT NULL COMMENT '患者 ID',
    visit_id        BIGINT       COMMENT '就诊记录 ID',
    doctor_id       BIGINT       NOT NULL COMMENT '开方医生 ID',
    formula_id      BIGINT       COMMENT '基于方剂 ID',
    diagnosis       VARCHAR(200) COMMENT '诊断',
    syndrome        VARCHAR(200) COMMENT '证型',
    notes           TEXT         COMMENT '医嘱备注',
    status          VARCHAR(20)  DEFAULT 'draft' COMMENT '状态',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (visit_id)   REFERENCES visit_record(id),
    FOREIGN KEY (doctor_id)  REFERENCES sys_user(id),
    FOREIGN KEY (formula_id) REFERENCES formula(id),
    INDEX idx_patient (patient_id),
    INDEX idx_status (status)
) COMMENT '处方表';

-- 11. prescription_item — 处方药材明细表
CREATE TABLE prescription_item (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    prescription_id BIGINT      NOT NULL COMMENT '处方 ID',
    herb_id         BIGINT      NOT NULL COMMENT '药材 ID',
    herb_name       VARCHAR(50) NOT NULL COMMENT '药材名称（冗余）',
    dosage          DECIMAL(5,1) NOT NULL COMMENT '实际用量',
    unit            VARCHAR(5)  DEFAULT 'g' COMMENT '单位',
    sort_order      INT         DEFAULT 0 COMMENT '排序',
    FOREIGN KEY (prescription_id) REFERENCES prescription(id),
    FOREIGN KEY (herb_id)         REFERENCES herb(id),
    INDEX idx_prescription (prescription_id)
) COMMENT '处方药材明细表';

-- 12. prescription_review — 处方审核记录表
CREATE TABLE prescription_review (
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    prescription_id BIGINT       NOT NULL COMMENT '处方 ID',
    reviewer_id     BIGINT       COMMENT '审核人 ID',
    review_status   VARCHAR(20)  DEFAULT 'pending' COMMENT '审核状态',
    review_comment  TEXT         COMMENT '审核意见',
    risk_score      INT          COMMENT '风险评分（0-100）',
    incompatibility_found TEXT   COMMENT '配伍禁忌',
    dosage_warnings      TEXT    COMMENT '剂量警告',
    reviewed_at     DATETIME     COMMENT '审核时间',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (prescription_id) REFERENCES prescription(id),
    FOREIGN KEY (reviewer_id)     REFERENCES sys_user(id),
    INDEX idx_review_status (review_status),
    INDEX idx_prescription_review (prescription_id)
) COMMENT '处方审核记录表';

-- 13. emr — 电子病历表
CREATE TABLE emr (
    id                  BIGINT PRIMARY KEY AUTO_INCREMENT,
    patient_id          BIGINT       NOT NULL COMMENT '患者 ID',
    visit_id            BIGINT       COMMENT '就诊记录 ID',
    prescription_id     BIGINT       COMMENT '关联处方 ID',
    visit_date          DATE         NOT NULL COMMENT '就诊日期',
    chief_complaint     TEXT         COMMENT '主诉',
    present_illness     TEXT         COMMENT '现病史',
    past_history        TEXT         COMMENT '既往史',
    tongue_image        TEXT         COMMENT '舌象描述',
    pulse_image         TEXT         COMMENT '脉象描述',
    complexion          VARCHAR(50)  COMMENT '面色',
    voice               VARCHAR(50)  COMMENT '语声',
    syndrome            VARCHAR(200) COMMENT '证型',
    diagnosis           VARCHAR(200) COMMENT '诊断',
    treatment_principle VARCHAR(200) COMMENT '治法/治则',
    prescription_text   TEXT         COMMENT '处方文字描述',
    notes               TEXT         COMMENT '医嘱/备注',
    treatment_result    VARCHAR(20)  COMMENT '疗效评估',
    follow_up           VARCHAR(100) COMMENT '复诊安排',
    doctor_id           BIGINT       NOT NULL COMMENT '主治医生 ID',
    status              VARCHAR(20)  DEFAULT 'active' COMMENT '状态',
    created_at          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id)      REFERENCES patient(id),
    FOREIGN KEY (visit_id)        REFERENCES visit_record(id),
    FOREIGN KEY (prescription_id) REFERENCES prescription(id),
    FOREIGN KEY (doctor_id)       REFERENCES sys_user(id),
    INDEX idx_patient_visit (patient_id, visit_date)
) COMMENT '电子病历表';

-- 14. syndrome_pattern — 证型知识表
CREATE TABLE syndrome_pattern (
    id                 BIGINT PRIMARY KEY AUTO_INCREMENT,
    pattern_name       VARCHAR(100) NOT NULL UNIQUE COMMENT '证型名称',
    pattern_code       VARCHAR(20)  COMMENT '证候编码',
    category           VARCHAR(50)  COMMENT '证型分类',
    etiology           VARCHAR(200) COMMENT '病因',
    pathogenesis       VARCHAR(200) COMMENT '病机',
    key_symptoms       TEXT         COMMENT '关键症状',
    pulse_pattern      VARCHAR(100) COMMENT '典型脉象',
    tongue_pattern     VARCHAR(100) COMMENT '典型舌象',
    differentiation    TEXT         COMMENT '辨证要点',
    treatment_method   VARCHAR(200) COMMENT '治法/治则',
    recommended_formula VARCHAR(100) COMMENT '推荐方剂',
    related_diagnosis  VARCHAR(200) COMMENT '对应西医诊断',
    sort_order         INT          DEFAULT 0 COMMENT '排序',
    created_at         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category)
) COMMENT '证型知识表';

-- 15. symptom_dict — 症状/标签字典表
CREATE TABLE symptom_dict (
    id             BIGINT PRIMARY KEY AUTO_INCREMENT,
    category       VARCHAR(50)  NOT NULL COMMENT '标签分类',
    sub_category   VARCHAR(50)  COMMENT '子分类',
    label          VARCHAR(100) NOT NULL COMMENT '标签名称',
    sort_order     INT          DEFAULT 0 COMMENT '排序',
    is_common      TINYINT      DEFAULT 0 COMMENT '是否常用',
    weight         INT          DEFAULT 0 COMMENT '权重',
    created_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_category_label (category, label),
    INDEX idx_category (category)
) COMMENT '症状/标签字典表';

-- 16. 插入默认管理员账户（密码占位，由沈文博生成正式哈希后替换）
INSERT INTO sys_user (username, password_hash, role, real_name) VALUES
('admin', 'placeholder_hash', 'admin', '系统管理员'),
('liyou', 'placeholder_hash', 'doctor', '李鮋'),
('shenwenbo', 'placeholder_hash', 'doctor', '沈文博'),
('luofangcheng', 'placeholder_hash', 'doctor', '罗方程');