FROM ubuntu:20.04

ENV RAILS_ENV=production

VOLUME ["/app"]

WORKDIR /app

RUN apt update && apt install -y wget libsqlite3-dev libmysqlclient-dev libpq-dev freetds-dev && rm -rf /var/lib/apt/lists/*

RUN wget -O adsnap-admin https://github.com/teamsnap/adsnap-admin/releases/download/latest/adsnap-admin-Linux-$(uname -m) && chmod +x ./adsnap-admin && mv ./adsnap-admin /usr/bin

EXPOSE 3000

CMD ["/bin/sh" , "-c" , "cd /app && adsnap-admin"]
