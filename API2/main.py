from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import models, schemas
from database import engine, get_db
import hashlib

# Créer les tables dans la base de données
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="Todo API")

# Fonction utilitaire pour hasher les mots de passe
def hash_password(password: str):
    return hashlib.sha256(password.encode()).hexdigest()

@app.post("/users/", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = hash_password(user.password)
    db_user = models.User(
        email=user.email,
        username=user.username,
        hashed_password=hashed_password
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@app.get("/users/", response_model=List[schemas.User])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = db.query(models.User).offset(skip).limit(limit).all()
    return users

@app.post("/users/{user_id}/todos/", response_model=schemas.Todo)
def create_todo(user_id: int, todo: schemas.TodoCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    
    db_todo = models.Todo(**todo.dict(), user_id=user_id)
    db.add(db_todo)
    db.commit()
    db.refresh(db_todo)
    return db_todo

@app.get("/todos/", response_model=List[schemas.Todo])
def read_todos(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    todos = db.query(models.Todo).offset(skip).limit(limit).all()
    return todos

@app.get("/")
def read_root():
    return {"message": "Bienvenue sur l'API Todo!"} 