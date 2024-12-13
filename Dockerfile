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

# 새로운 사용자 및 그룹 생성
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -m appuser

# 작업 디렉토리 설정 및 권한 변경
RUN chown -R appuser:appgroup /app

# 필요한 파일 복사
COPY package.json package-lock.json ./

# 파일 권한 설정: 읽기 전용
RUN chmod 644 ./package-lock.json ./package.json && \
    chown appuser:appgroup ./package-lock.json ./package.json

# 사용자 변경
USER appuser

# 패키지 설치
RUN npm install

# 소스 코드 복사
COPY . .

FROM node:18
WORKDIR /app

# 디렉토리 복사 및 권한 설정
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/public ./public
COPY --from=builder /app/routes ./routes
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js ./

# 최종 권한 설정
RUN chown -R node:node /app && \
    chmod -R 755 /app && \
    chmod -R 700 /app/bin

# 기본 사용자 설정
USER node

EXPOSE 3004

# 실행
CMD ["npm", "start"]