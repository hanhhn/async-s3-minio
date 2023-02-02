FROM docker.io/ubuntu:latest as builder
RUN apt-get update && apt-get install -y curl unzip wget
RUN curl -O 'https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip'
RUN unzip awscli-exe-linux-aarch64.zip
RUN ./aws/install && aws --version

COPY credentials /root/.aws/credentials
COPY config /root/.aws/config
COPY sync-data.sh .
RUN chmod +x /sync-data.sh
ENV HOST 0.0.0.0

CMD ["/sync-data.sh"]
