import uuid
from fastapi import APIRouter, HTTPException
from app.schemas import CreateDoctorSchema, UpdateDoctorSchema, DoctorResponse
from app.models import Doctor
from app.database import SessionLocal

router = APIRouter()

@router.get("/")
async def get_doctors():
    db = SessionLocal()
    try:
        doctors = db.query(Doctor).all()
        return [{"id": Doctor.id, "name": Doctor.name, "role_detail": Doctor.role_detail, "rating": Doctor.rating , "price": Doctor.price, "university": Doctor.university, "yearofexperience": Doctor.yearofexperience} for Doctor in doctors]
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()

@router.get("/{doctor_id}")
async def get_doctor(doctor_id: uuid.UUID):
    db = SessionLocal()
    try:
        doctor = db.query(Doctor).filter(Doctor.id == doctor_id).first()
        if not doctor:
            raise HTTPException(status_code=404, detail="Doctor not found")
        return doctor
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()        

@router.post("/")
async def create_doctor(doctor: CreateDoctorSchema):
    db = SessionLocal()
    try:
        new_doctor = Doctor(**doctor.dict())
        db.add(new_doctor)
        db.commit()
        db.refresh(new_doctor)
        return {"message": "Doctor created successfully", "doctor": new_doctor.__dict__}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()

@router.put("/{doctor_id}")
async def update_doctor(doctor_id: uuid.UUID, doctor: UpdateDoctorSchema):
    db = SessionLocal()
    try:
        existing_doctor = db.query(Doctor).filter(Doctor.id == doctor_id).first()
        if not existing_doctor:
            raise HTTPException(status_code=404, detail="Doctor not found")
        for attr, value in doctor.dict().items():
            setattr(existing_doctor, attr, value)
        db.commit()
        return {"message": "Doctor updated successfully", "doctor": existing_doctor.__dict__}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        db.close()
        