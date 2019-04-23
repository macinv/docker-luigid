FROM python:3.6

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN mkdir -p /var/lib/luigi/data
RUN touch /var/lib/luigi/data/luigi.db
RUN mkdir /etc/luigi
ADD client.cfg /etc/luigi/client.cfg

VOLUME /etc/luigi
VOLUME /var/lib/luigi

RUN rm /tmp/*

EXPOSE 8082
CMD ["luigid"]
