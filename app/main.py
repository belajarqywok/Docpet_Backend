from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings
from app.routers import user, auth, upload, pet, disease_detection, doctor

app = FastAPI()

origins = [
    settings.CLIENT_ORIGIN,
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(auth.router, tags=['Auth'], prefix='/api/auth')
app.include_router(user.router, tags=['Users'], prefix='/api/users')
app.include_router(upload.router, tags=['Upload'], prefix='/api/upload')
app.include_router(pet.router, tags=['Pets'], prefix='/api/pets')
app.include_router(doctor.router, tags=['Doctors'], prefix='/api/doctors')

app.include_router(
    tags = ['Disease Detection'],
    router = disease_detection.router,
    prefix = '/api/disease_detection'
)

@app.get('/api/checker')
def root():
    return {'message': 'Hello Docpet!'}
