# FROM node
# WORKDIR /usr/src/app
# COPY package.json ./
# RUN npm install
# COPY ./ ./
# CMD [ "node", "./bin/www" ]

# FROM node
# CMD echo "나는야 소스 될거야"
# CMD echo "나는야 주스 될거야"

# FROM ubuntu:20.04

# CMD ["토마토송을 부르겠습니다."]

# ENTRYPOINT ["echo"]
# FROM ubuntu:20.04
# RUN echo "토마토송을 부르겠습니다." > song.txt
# RUN echo "생일축하송을 부르겠습니다." >> song.txt
# RUN echo "스완송을 부르겠습니다."  >> song.txt

# CMD cat song.txt

# FROM ubuntu:20.04
# WORKDIR /app1
# WORKDIR /app
# CMD echo "$PWD\n"; ls -ld /app

# FROM node:21-alpine
# WORKDIR /usr/src/app
# COPY . .
# CMD ls

FROM node:18 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules

ENV PORT=3004
EXPOSE $PORT
CMD ["node", "server.js"]