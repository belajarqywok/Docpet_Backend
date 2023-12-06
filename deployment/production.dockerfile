FROM python:3.9-bullseye

LABEL team="cloud-computing-team"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /etc/docpet_backend_service

RUN python3 -m pip install --upgrade pip

COPY requirements.txt /etc/docpet_backend_service/
RUN pip3 install -r requirements.txt

COPY . /etc/docpet_backend_service/

RUN alembic upgrade head && \
        alembic revision --autogenerate -m "migrate"

EXPOSE 80
CMD [ "/bin/bash", "-c", "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 80 --workers 10" ]