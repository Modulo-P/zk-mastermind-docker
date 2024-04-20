FROM node:21-alpine

RUN yarn set version stable

USER node

WORKDIR /home/node/app

ADD --chown=node:node repo ./

RUN yarn 

RUN yarn build

EXPOSE 3000

CMD "yarn" "start"