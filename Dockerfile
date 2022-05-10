FROM python:3.7-alpine
#MAINTAINER London App Developer Ltd

ENV PYTHONONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# For security reason we don't want to run the app with sudo access
RUN adduser -D user
USER user