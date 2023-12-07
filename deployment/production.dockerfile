FROM python:3.9-bullseye

LABEL team="cloud-computing-team"

# Write Byte Code and Buffered
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set Working Directory
WORKDIR /etc/docpet_backend_service

# Upgrade PIP
RUN python3 -m pip install --upgrade pip

# Install the Requirements
COPY requirements/linux.requirements.txt \
    /etc/docpet_backend_service/

RUN pip3 install -r linux.requirements.txt

COPY . /etc/docpet_backend_service/

EXPOSE 80

CMD [ "/bin/bash", "-c", "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 80 --workers 10" ]