import json
import numpy as np
from passlib.context import CryptContext
from tensorflow.keras.models import load_model
from tensorflow.keras.utils import load_img, img_to_array

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(password: str, hashed_password: str):
    return pwd_context.verify(password, hashed_password)

def image_prediction(image_location: str) -> dict:
    labels = json.load(open("./ml_models/labels.json")) \
        .get("disease_labels")

    model = load_model('./ml_models/model.h5')

    image = load_img(image_location, target_size = (150, 150))

    x = np.expand_dims(a = img_to_array(image), axis = 0)
    
    images = np.vstack(tup = [x])
    classes = model.predict(x = images, batch_size = 16)

    for idx_predict, class_value in enumerate(classes[0]):
        if class_value == 1:
            label = labels[idx_predict]
            break
    else: label = None

    return label