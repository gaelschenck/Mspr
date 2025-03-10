from pydantic import BaseModel, EmailStr, conint, confloat
from datetime import datetime
from typing import Optional, List

# Todo schemas
class TodoBase(BaseModel):
    title: str
    description: Optional[str] = None
    completed: bool = False

class TodoCreate(TodoBase):
    pass

class Todo(TodoBase):
    id: int
    created_at: datetime
    user_id: int

    class Config:
        from_attributes = True

# Product schemas
class ProductBase(BaseModel):
    name: str
    description: Optional[str] = None
    price: confloat(gt=0)
    stock: conint(ge=0)

class ProductCreate(ProductBase):
    pass

class Product(ProductBase):
    id: int
    created_at: datetime
    user_id: int

    class Config:
        from_attributes = True

# OrderItem schemas
class OrderItemBase(BaseModel):
    product_id: int
    quantity: conint(gt=0)
    price: confloat(gt=0)

class OrderItemCreate(OrderItemBase):
    pass

class OrderItem(OrderItemBase):
    id: int
    order_id: int

    class Config:
        from_attributes = True

# Order schemas
class OrderBase(BaseModel):
    total_amount: confloat(gt=0)
    status: str

class OrderCreate(OrderBase):
    items: List[OrderItemCreate]

class Order(OrderBase):
    id: int
    created_at: datetime
    user_id: int
    items: List[OrderItem] = []

    class Config:
        from_attributes = True

# User schemas
class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    created_at: datetime
    todos: List[Todo] = []
    products: List[Product] = []
    orders: List[Order] = []

    class Config:
        from_attributes = True 