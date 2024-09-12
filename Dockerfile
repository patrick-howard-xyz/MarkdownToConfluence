FROM ubuntu:latest

RUN apt-get update && apt-get install -y software-properties-common gcc && \
   add-apt-repository -y ppa:deadsnakes/ppa

RUN apt-get install -y python3.6 python3-setuptools python3-pip python3-apt python3-venv

RUN python3 -m venv venv
RUN chmod +x /venv/*
RUN . /venv/bin/activate

RUN apt-get -y install git jq

COPY setup.py /setup.py
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./MarkdownToConfluence /MarkdownToConfluence
RUN pip install -e .

RUN chmod +x /MarkdownToConfluence/convert_all.sh
RUN chmod +x /MarkdownToConfluence/convert.sh
RUN chmod +x /MarkdownToConfluence/entrypoint.sh

ENTRYPOINT [ "bash", "/MarkdownToConfluence/entrypoint.sh" ]