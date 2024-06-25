ARG BASE_IMAGE=nvidia/cuda:12.5.0-runtime-ubuntu22.04

# Use an official Python runtime as a parent image
FROM ${BASE_IMAGE}

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

RUN apt-get update && apt-get -y install apt-utils python3 python3-pip 

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    torch \
    numpy

CMD ["/app/start.sh"]