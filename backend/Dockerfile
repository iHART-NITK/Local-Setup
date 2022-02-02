FROM python:3
ENV PYTHONUNBUFFERED=1

WORKDIR /server
RUN apt-get -q update && apt-get -qy install netcat

COPY requirements.txt /server/
RUN pip3 install -r requirements.txt

COPY . /server/

RUN chmod +x wait-for-it.sh
RUN chmod +x backend.sh

CMD ["./wait-for-it.sh","ihartdb:3306", "--", "sh", "./backend.sh"]