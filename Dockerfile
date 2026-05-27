# nginx 공식 이미지를 베이스로 사용
FROM nginx:alpine

# 작성자 정보 (선택)
LABEL maintainer="SW Maestro Mentor"
LABEL description="Container 기초 실습용 정적 웹 페이지"

# 로컬의 index.html을 nginx의 기본 웹 루트로 복사
# nginx:alpine 이미지는 /usr/share/nginx/html 경로의 파일을 서빙함
COPY index.html /usr/share/nginx/html/index.html

# nginx는 기본적으로 80번 포트를 사용
EXPOSE 80

# 베이스 이미지에 CMD가 이미 정의되어 있어 별도 명령 불필요
# (참고: nginx -g "daemon off;" 로 포그라운드 실행)
