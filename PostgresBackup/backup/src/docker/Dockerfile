FROM postgres:14.4

RUN apt update && apt install -y wget curl openssh-client sshpass rsync

RUN curl -fLsS "https://storage.googleapis.com/kubernetes-release/release/v1.17.4/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
        && chmod +x /usr/local/bin/kubectl

COPY backup.sh backup.sh

CMD [ "/bin/sh", "./backup.sh" ]
