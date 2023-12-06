import os
from http import HTTPStatus
from app.gcs import upload_blob
from app.oauth2 import require_user
from app.utils import image_prediction
from fastapi.responses import JSONResponse
from fastapi import UploadFile, File, Depends, APIRouter

router = APIRouter()

@router.post("/")
async def disease_detection(
    file: UploadFile = File(...), 
    _: str = Depends(require_user)
):
    try:
        file.file.seek(0, 2)
        file_size = file.file.tell()

        await file.seek(0)

        # 1 kb = 1024 bytes
        # 1 mb = 1024 kb
        if file_size > 10 * 1024 * 1024:
            # more than 10 mb
            return JSONResponse(
                content = {
                    'message': 'file too large (MAX: 10 MB)',
                    'status_code': HTTPStatus.BAD_REQUEST,
                    'data': None
                },
                status_code = HTTPStatus.BAD_REQUEST
            )

        content_type = file.content_type
        if content_type not in ["image/jpeg", "image/jpg", "image/png"]:
            return JSONResponse(
                content = {
                    'message': 'invalid file type',
                    'status_code': HTTPStatus.BAD_REQUEST,
                    'data': None
                },
                status_code = HTTPStatus.BAD_REQUEST
            )

        file_location = f"temp/{file.filename}"
        os.makedirs(os.path.dirname(file_location), exist_ok=True)

        with open(file_location, "wb+") as file_object:
            file_object.write(file.file.read())

        # Prediction Result
        predict_result = image_prediction(file_location)

        upload_blob("docpet-dev-test", file_location, file.filename)
        os.remove(file_location)

        return JSONResponse(
            content = {
                'message': 'prediction success',
                'status_code': HTTPStatus.OK,
                'data': predict_result
            },
            status_code = HTTPStatus.OK
        )

    except Exception as e:
        return JSONResponse(
            content = {
                'message': 'Internal Server Error',
                'status_code': HTTPStatus.INTERNAL_SERVER_ERROR,
                'data': None
            },
            status_code = HTTPStatus.INTERNAL_SERVER_ERROR
        )
