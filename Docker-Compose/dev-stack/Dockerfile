FROM node:16-alpine

WORKDIR /app
RUN apk add --no-cache \
    git \
    autoconf \
    automake \
    make \
    g++ \
    libtool \
    nasm \
    libpng-dev

RUN git clone https://github.com/ritz078/transform.git .
RUN yarn install --frozen-lockfile
RUN yarn build
EXPOSE 3000

ENTRYPOINT ["yarn", "start"]