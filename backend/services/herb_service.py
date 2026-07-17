"""药材业务逻辑"""
from typing import List, Optional
from sqlalchemy.orm import Session

from models.herb import Herb


def search_herbs(db: Session, keyword: Optional[str] = None, category: Optional[str] = None) -> List[Herb]:
    q = db.query(Herb)
    if keyword:
        q = q.filter(Herb.name.contains(keyword))
    if category:
        q = q.filter(Herb.category == category)
    return q.all()


def get_herb_by_id(db: Session, herb_id: int) -> Optional[Herb]:
    return db.query(Herb).filter(Herb.id == herb_id).first()