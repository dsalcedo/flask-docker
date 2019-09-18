FROM python:3.7-alpine

RUN apk add tzdata && \
    cp /usr/share/zoneinfo/America/Mexico_City /etc/localtime && \
    echo "America/Mexico_City" >  /etc/timezone && \
    apk del tzdata

# Place your flask application on the server
COPY ./app /app
ADD . app
WORKDIR /app

RUN apk update \
    && apk add --virtual build-dependencies build-base gcc linux-headers \
    # Pillow dependencies
    jpeg-dev \
    zlib-dev \
    && apk add bash \
    && pip install -qU pip \
    && pip install --no-cache-dir -r requirements.txt

# RUN rm /etc/nginx/nginx.conf
# COPY ./nginx/nginx.conf /etc/nginx/
# RUN rm /etc/nginx/conf.d/default.conf
# COPY ./nginx/app.conf /etc/nginx/conf.d/

ENV PYTHONPATH=/app

ENTRYPOINT ["python"]

CMD ["main.py"]
EXPOSE 5000
