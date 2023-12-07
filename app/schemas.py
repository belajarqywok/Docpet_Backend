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

class DoctorBaseSchema(BaseModel):
    name: constr(max_length=20) = Field(..., description="Doctor's name")
    price: str = Field(..., description="Doctor's price")
    rating: str = Field(..., description="Doctor's rating")
    role: str = Field(..., description="Doctor's role")
    role_detail: str = Field(..., description="Doctor's detail")
    day: str = Field(..., description="Doctor's day")
    time: str = Field(..., description="Doctor's time")
    location: str = Field(..., description="Doctor's location")
    university: str = Field(..., description="Doctor's university")
    yearofexperience: str = Field(..., description="Doctor's year of experience")

class CreateDoctorSchema(DoctorBaseSchema):
    pass

class UpdateDoctorSchema(DoctorBaseSchema):
    pass

class DoctorResponse(DoctorBaseSchema):
    id: uuid.UUID
    created_at: datetime
    updated_at: datetime