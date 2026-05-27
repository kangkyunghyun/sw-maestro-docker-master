# nginx 공식 이미지를 베이스로 사용
FROM nginx:alpine

# 로컬의 index.html을 nginx의 기본 웹 루트로 복사
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

# --- 학습 포인트: ENTRYPOINT와 CMD의 관계 ---
# ENTRYPOINT: 항상 실행되는 "고정된 명령"
# CMD       : ENTRYPOINT에 전달되는 "기본 인자" (docker run 시 덮어쓰기 가능)
#
# 아래 설정은 결국 다음 명령으로 실행됨:
#   nginx -g "daemon off;"
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
