FROM python:3.9-bullseye

LABEL organization="docpet"
LABEL team="cloud-computing-team"
LABEL backend_engineer="Putu Wira Pratama Putra"
LABEL Infra_engineer="Al-Fariqy Raihan Azhwar"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"

WORKDIR /etc/docpet_backend_service

RUN python3 -m pip install --upgrade pip

COPY --chown=user requirements/linux.requirements.txt \
    /etc/docpet_backend_service/

RUN pip install --no-cache-dir --upgrade -r linux.requirements.txt

COPY --chown=user . /etc/docpet_backend_service/

RUN wget -O /etc/docpet_backend_service/ml_models/model.h5 \
  https://github.com/belajarqywok/mbadhog/raw/main/model.h5

EXPOSE 7860

CMD [ "alembic upgrade head && uvicorn app:app --host 0.0.0.0 --port 7860 --workers 30" ]
