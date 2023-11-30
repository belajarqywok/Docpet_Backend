from passlib.context import CryptContext
# use passlib to hash and verify passwords

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
# use bcrypt to hash and verify passwords

#
def hash_password(password: str):
    return pwd_context.hash(password)


def verify_password(password: str, hashed_password: str):
    return pwd_context.verify(password, hashed_password)
