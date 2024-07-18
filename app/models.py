import uuid # uuid is used to generate a random unique id for each user
from .database import Base
from sqlalchemy import TIMESTAMP, Column, String, Boolean, text, Enum
from sqlalchemy.dialects.postgresql import UUID

# User model
class User(Base):
    __tablename__ = 'users'
    id = Column(UUID(as_uuid=True), primary_key=True, nullable=False,
                default=uuid.uuid4)
    name = Column(String,  nullable=False)
    email = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    verified = Column(Boolean, nullable=False, server_default='False')
    role = Column(String, server_default='user', nullable=False)
    created_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))
    updated_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))

class Pet(Base):
    __tablename__ = 'pets'
    id = Column(UUID(as_uuid=True), primary_key=True, nullable=False,
                default=uuid.uuid4)
    name = Column(String, nullable=False)
    age = Column(String, nullable=False)
    gender = Column(Enum('Jantan', 'Betina', name='gender'), nullable=False)
    created_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))
    updated_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))
    
class Doctor(Base):
    __tablename__ = 'doctors'
    id = Column(UUID(as_uuid=True), primary_key=True, nullable=False,
                default=uuid.uuid4)
    name = Column(String, unique=True, nullable=False)
    price = Column(String, nullable=False)
    rating = Column(String, nullable=False)
    role = Column(String, server_default='Hewan', nullable=False)
    role_detail = Column(String, nullable=False)
    day = Column(String, nullable=True)
    time = Column(String, nullable=False)
    location = Column(String, nullable=False)
    university = Column(String, nullable=False)
    yearofexperience = Column(String, nullable=False)
    created_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))
    updated_at = Column(TIMESTAMP(timezone=True),
                        nullable=False, server_default=text("now()"))