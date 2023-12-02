from datetime import datetime
import uuid
from pydantic import BaseModel, EmailStr, constr, Field
from enum import Enum


class UserBaseSchema(BaseModel):
    name: str
    email: EmailStr

    class Config:
        orm_mode = True


class CreateUserSchema(UserBaseSchema):
    password: constr(min_length=8)
    passwordConfirm: str
    role: str = 'user'
    verified: bool = False


class LoginUserSchema(BaseModel):
    email: EmailStr
    password: constr(min_length=8)


class UserResponse(UserBaseSchema):
    id: uuid.UUID
    created_at: datetime
    updated_at: datetime

class GenderEnum(str, Enum):
    Jantan = 'Jantan'
    Betina = 'Betina'

class PetBaseSchema(BaseModel):
    name: constr(max_length=20) = Field(..., description="Pet's name")
    gender: GenderEnum = Field(..., description="Pet's gender")
    age: str = Field(..., description="Pet's age")

class CreatePetSchema(PetBaseSchema):
    pass

class UpdatePetSchema(PetBaseSchema):
    pass