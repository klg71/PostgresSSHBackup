FROM postgres:14.4

RUN apt update && apt install -y wget curl openssh-client sshpass rsync

COPY . .

ENTRYPOINT [ "/bin/sh", "./apply.sh" ]

