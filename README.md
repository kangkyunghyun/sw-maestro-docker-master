# 🐳 Docker 기초 실습 — nginx로 정적 웹페이지 띄우기

SW Maestro 컨테이너 기초 강의 실습 자료입니다.
**Dockerfile → 이미지 빌드 → 컨테이너 실행** 한 사이클을 가장 짧은 코드로 체험합니다.

---

## 📁 파일 구성

```
docker-nginx-demo/
├── Dockerfile     # 이미지 빌드 명세
├── index.html     # 서빙할 정적 페이지
└── README.md      # (이 문서)
```

---

## 🛠 사전 준비

- Docker가 설치되어 있어야 합니다.
  ```bash
  docker version    # Client/Server 모두 보이면 OK
  ```
- 설치가 안 되어 있다면 (Ubuntu 기준):
  ```bash
  sudo apt-get update && sudo apt-get install docker.io -y
  sudo usermod -aG docker $USER && newgrp docker
  ```

---

## 🚀 실습 순서

### 1. 저장소 클론

```bash
git clone <YOUR_REPO_URL>
cd docker-nginx-demo
```

### 2. 이미지 빌드

```bash
docker build -t my-nginx-demo:v1 .
```

- `-t my-nginx-demo:v1` → 이미지 이름과 태그 지정
- 마지막 `.` → 현재 디렉토리의 Dockerfile을 사용

빌드가 끝났는지 확인:
```bash
docker images | grep my-nginx-demo
```

### 3. 컨테이너 실행

```bash
docker run -d -p 8080:80 --name web my-nginx-demo:v1
```

- `-d` → 백그라운드 실행 (detached)
- `-p 8080:80` → 호스트 8080 포트를 컨테이너 80 포트로 연결
- `--name web` → 컨테이너 이름 지정

### 4. 동작 확인

브라우저에서 접속:
```
http://localhost:8080
```

또는 터미널에서:
```bash
curl http://localhost:8080
```

> EC2에서 실습 중이라면 **보안 그룹에서 8080 포트를 열어두고**
> `http://<EC2_PUBLIC_IP>:8080` 으로 접속하세요.

---

## 🔍 컨테이너 들여다보기 (Level 2 복습)

```bash
docker ps                   # 실행 중 컨테이너 목록
docker logs web             # 접속 로그
docker exec -it web sh      # 컨테이너 안으로 진입
docker inspect web          # 메타데이터 확인
```

컨테이너 안에 들어가서 직접 확인:
```bash
docker exec -it web sh
# 컨테이너 내부에서:
ls /usr/share/nginx/html/
cat /usr/share/nginx/html/index.html
exit
```

---

## 🧹 정리

```bash
docker stop web             # 컨테이너 중지
docker rm web               # 컨테이너 삭제
docker rmi my-nginx-demo:v1 # 이미지 삭제
```

---

## 💡 도전 과제

1. `index.html`의 내용을 바꾸고 **다시 빌드 → 실행**해 보세요.
   - 힌트: 기존 컨테이너를 먼저 `stop` + `rm` 해야 같은 이름으로 다시 실행할 수 있습니다.
2. 태그를 `v2`로 바꿔서 빌드한 뒤, `docker images`에서 `v1`과 `v2`가 모두 보이는지 확인해 보세요.
3. `docker history my-nginx-demo:v1` 명령으로 이미지의 레이어 구조를 살펴보세요.

---

## 🤔 자주 묻는 질문

**Q. `-p 8080:80`에서 앞뒤가 헷갈려요.**
A. **`호스트:컨테이너`** 순서입니다. 외부에서 접속하는 포트가 앞, 컨테이너 내부 포트가 뒤.

**Q. 빌드할 때마다 시간이 오래 걸려요.**
A. Docker는 **레이어 캐시**를 사용합니다. `COPY index.html ...` 위에 자주 안 바뀌는 명령을 두면 캐시 효율이 좋아집니다.

**Q. 컨테이너가 바로 꺼져요.**
A. `docker logs <컨테이너이름>` 으로 원인을 확인하세요. nginx는 포그라운드 실행이 기본이라 정상이라면 계속 떠 있어야 합니다.
