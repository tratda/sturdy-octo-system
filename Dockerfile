FROM python:3.5-slim

WORKDIR /web

ADD . /web

RUN pip install --trusted-host pypi.python.org -r Requirements.txt

EXPOSE 443

ENV NAME World

CMD ["python3", "app.py"]
