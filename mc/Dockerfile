FROM docker.io/ubuntu:20.04 as builder

RUN apt-get update && apt-get install -y curl unzip wget

RUN curl -O 'https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip'
RUN unzip awscli-exe-linux-aarch64.zip
RUN ./aws/install && aws --version

RUN curl 'https://dl.min.io/client/mc/release/linux-arm64/mc' --create-dirs -o ~/minio-binaries/mc
RUN chmod +x $HOME/minio-binaries/mc
RUN export PATH=$PATH:$HOME/minio-binaries/ && mc --version

COPY sync-data.sh .
RUN chmod +x /sync-data.sh
ENV HOST 0.0.0.0

CMD ["/sync-data.sh"]
