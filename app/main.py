from fastapi import FastAPI
from app.config import settings
from fastapi.responses import RedirectResponse
from fastapi.middleware.cors import CORSMiddleware
from app.routers import user, auth, upload, pet, disease_detection, doctor

app = FastAPI()

origins = [
    settings.CLIENT_ORIGIN,
]

app.add_middleware(
    middleware_class = CORSMiddleware,
    allow_origins = ["*"],
    allow_methods = ["*"],
    allow_headers = ["*"],
    allow_credentials = True
)

# Auth Routes Group
app.include_router(
    tags = ['Auth'],
    router = auth.router,
    prefix = '/api/auth'
)

# User Routes Group
app.include_router(
    tags = ['Users'],
    router = user.router,
    prefix = '/api/users'
)

# Upload Routes Group
app.include_router(
    tags = ['Upload'],
    router = upload.router,
    prefix = '/api/upload'
)

# Pet Routes Group
app.include_router(
    tags = ['Pets'],
    router = pet.router,
    prefix = '/api/pets'
)

# Doctor Routes Group
app.include_router(
    tags = ['Doctors'],
    router = doctor.router,
    prefix = '/api/doctors'
)

# Disease Detection Routes Group
app.include_router(
    tags = ['Disease Detection'],
    router = disease_detection.router,
    prefix = '/api/disease_detection'
)

# Main Routes Group
@app.get('/api/checker', tags = ['Main'])
def checker():
    return {'message': 'Hello Docpet!'}

@app.get("/", tags = ['Main'])
def root():
    return RedirectResponse(url="/docs")
    