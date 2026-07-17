"""FastAPI 应用入口：注册路由、中间件、启动事件"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from core.config import settings
from routers import (
    auth, patients, visits, herbs, formulas,
    prescriptions, review, statistics, emrs,
    syndrome_patterns, symptom_dict,
)

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="基层中医智慧诊疗系统后端 API",
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.on_event("startup")
async def startup() -> None:
    # TODO: 初始化数据库连接、预热缓存等
    pass


@app.on_event("shutdown")
async def shutdown() -> None:
    # TODO: 释放资源
    pass


@app.get("/")
def health_check():
    return {"status": "ok", "service": settings.PROJECT_NAME}


# 注册路由
app.include_router(auth.router, prefix=f"{settings.API_V1_STR}/auth", tags=["认证"])
app.include_router(patients.router, prefix=f"{settings.API_V1_STR}/patients", tags=["患者"])
app.include_router(visits.router, prefix=f"{settings.API_V1_STR}/visits", tags=["就诊"])
app.include_router(herbs.router, prefix=f"{settings.API_V1_STR}/herbs", tags=["药材"])
app.include_router(formulas.router, prefix=f"{settings.API_V1_STR}/formulas", tags=["方剂"])
app.include_router(prescriptions.router, prefix=f"{settings.API_V1_STR}/prescriptions", tags=["处方"])
app.include_router(review.router, prefix=f"{settings.API_V1_STR}/review", tags=["审核"])
app.include_router(statistics.router, prefix=f"{settings.API_V1_STR}/statistics", tags=["统计"])
app.include_router(emrs.router, prefix=f"{settings.API_V1_STR}/emrs", tags=["病历"])
app.include_router(syndrome_patterns.router, prefix=f"{settings.API_V1_STR}/syndrome-patterns", tags=["证型字典"])
app.include_router(symptom_dict.router, prefix=f"{settings.API_V1_STR}/symptom-dict", tags=["症状字典"])
