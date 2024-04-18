FROM node:21-alpine

RUN yarn set version stable

RUN apk add gcc clang python3 make g++

USER node

WORKDIR /home/node/app

ADD --chown=node:node repo ./

RUN yarn 

RUN yarn build

EXPOSE 3004

CMD "node" "dist/index.js"