FROM debian:jessie

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	curl \
	wget \
	nano

RUN	curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\
	apt-get install -y nodejs

RUN useradd --user-group --create-home --shell /bin/false app 

ENV HOME=/home/app
ENV SRC=/home/app/src

COPY package.json npm-shrinkwrap.json $HOME/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME
RUN npm install

USER root
COPY src/ $SRC/
RUN chown -R app:app $HOME/*
USER app

CMD ["node", "src/index.js"]
