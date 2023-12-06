from fastapi import UploadFile, File, APIRouter
from app.gcs import upload_blob
import os

router = APIRouter()

@router.post("/")
async def upload_file(file: UploadFile = File(...)):
    try:
        file_location = f"temp/{file.filename}"
        os.makedirs(os.path.dirname(file_location), exist_ok=True)
        with open(file_location, "wb+") as file_object:
            file_object.write(file.file.read())
        upload_blob("docpet-dev-test", file_location, file.filename)
        return {"success": True, "filename": file.filename, "message": "File uploaded successfully"}
    except Exception as e:
        return {"success": False, "message": str(e)}
