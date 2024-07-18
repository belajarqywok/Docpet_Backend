import uuid
from fastapi import APIRouter, HTTPException
from api.schemas import CreatePetSchema, UpdatePetSchema
from api.models import Pet
from api.database import SessionLocal

router = APIRouter()

@router.get("/")
async def get_pets():
    db = SessionLocal()
    try:
        pets = db.query(Pet).all()
        return [{"id": pet.id, "name": pet.name, "age": pet.age} for pet in pets]
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()

@router.post("/")
async def create_pet(pet: CreatePetSchema):
    db = SessionLocal()
    try:
        new_pet = Pet(**pet.dict())
        db.add(new_pet)
        db.commit()
        return {"id": new_pet.id, "name": new_pet.name, "age": new_pet.age}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()

@router.put("/{pet_id}", response_model=UpdatePetSchema)
async def update_pet(pet_id: uuid.UUID, pet: UpdatePetSchema):
    db = SessionLocal()
    try:
        existing_pet = db.query(Pet).filter(Pet.id == pet_id).first()
        if not existing_pet:
            raise HTTPException(status_code=404, detail="Pet not found")
        for attr, value in pet.dict().items():
            setattr(existing_pet, attr, value)
        db.commit()
        return {"id": existing_pet.id, "name": existing_pet.name, "age": existing_pet.age, "gender": existing_pet.gender}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()