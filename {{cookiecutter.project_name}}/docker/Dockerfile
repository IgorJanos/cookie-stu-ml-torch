# syntax=docker/dockerfile:1
FROM dockerhub.deepmagic.sk/stu/dev-base:latest

# Update the APT-GET
RUN apt-get update --fix-missing
RUN apt-get install apt-transport-https
RUN apt-get install ca-certificates
RUN update-ca-certificates
RUN apt-get install unzip

# Install required packages
WORKDIR /setup
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
