FROM python:3.10-alpine AS compile-image
RUN apk add --no-cache libpq-dev gcc libc-dev

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.10-alpine AS build-image
COPY --from=compile-image /opt/venv /opt/venv

ENV PORT=8082

RUN mkdir -p /var/lib/luigi/data
RUN touch /var/lib/luigi/data/luigi.db
RUN mkdir /etc/luigi
ADD client.cfg /etc/luigi/client.cfg

VOLUME /etc/luigi
VOLUME /var/lib/luigi

ENV PATH="/opt/venv/bin:${PATH}"
EXPOSE ${PORT}
CMD ["luigid"]
