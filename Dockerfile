FROM ethereum/client-go:alltools-latest

ENTRYPOINT ["/bin/sh"]

USER root
RUN adduser -s /bin/sh -D ethuser
RUN apk update

RUN apk add git nodejs npm curl bash

WORKDIR /home/ethuser
RUN npm install web3 express


USER ethuser
RUN mkdir data config

COPY --chown=ethuser config /home/ethuser/config

RUN git clone https://github.com/cubedro/eth-net-intelligence-api monitor
COPY ./netstat/app.json monitor
WORKDIR /home/ethuser/monitor
RUN npm install pm2
RUN npm install

WORKDIR /home/ethuser

EXPOSE 9090 9091 8545 8546 30301/udp 30303 30303/udp 30304