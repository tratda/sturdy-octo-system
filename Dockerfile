FROM python:3.5-slim

RUN apt-get update

RUN apt-get -y install git-core ssh

RUN pip3 install --upgrade pip

RUN useradd admin

RUN mkdir -p /home/admin/admin

RUN echo "admin:empiredidnothingwrong" | chpasswd

RUN chown -R admin:admin /home/admin/

WORKDIR /home/admin/admin/ 

RUN su admin -c "git init --shared"

WORKDIR /web

ADD . /web

RUN pip3 install -r Requirements.txt

EXPOSE 80

EXPOSE 22

ENV NAME World

CMD ["python3", "app.py"]
