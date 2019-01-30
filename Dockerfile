FROM node:10.8-alpine as build
WORKDIR /app

COPY package.json yarn.lock /app/
RUN yarn

COPY . /app/
RUN yarn babel src --out-dir lib

FROM node:10.8-alpine

RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

WORKDIR /app

COPY package.json yarn.lock /app/
RUN yarn --production
COPY --from=build /app/lib /app/src

CMD ["node", "/app/src/index.js"]
