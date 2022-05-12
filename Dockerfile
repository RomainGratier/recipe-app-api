FROM python:3.7-alpine
#MAINTAINER London App Developer Ltd

ENV PYTHONONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# For security reason we don't want to run the app with sudo access
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user