FROM python:3

MAINTAINER Pete Lambro "peterlambro@gmail.com"

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

EXPOSE 8000

ENV UPLOAD_FOLDER="./uploads/"

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8000", "app:app"]