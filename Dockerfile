FROM ubuntu

RUN apt-get update
RUN apt install -y curl

RUN curl -sL https://deb.nodesource.com/setup_25.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt install -y nodejs

COPY index.js /home/node-demo/index.js
COPY package.json /home/node-demo/package.json

WORKDIR /home/node-demo/

RUN npm install

EXPOSE 3000

CMD ["node", "index.js"]