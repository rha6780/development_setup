#!/bin/bash

set -e

echo "=== 패키지 업데이트 ==="
apt-get update -y
apt-get upgrade -y

echo "=== qemu-guest-agent 설치 ==="
apt-get install -y qemu-guest-agent

echo "=== qemu-guest-agent 서비스 활성화 ==="
systemctl enable qemu-guest-agent
systemctl start qemu-guest-agent

echo "=== Docker 설치 준비: 필수 패키지 설치 ==="
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "=== Docker GPG Key 등록 ==="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Docker 리포지토리 추가 ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Docker 설치 ==="
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Docker 서비스 활성화 ==="
systemctl enable docker
systemctl start docker

echo "=== 현재 사용자 '${SUDO_USER:-$USER}'을 docker 그룹에 추가 ==="
usermod -aG docker ${SUDO_USER:-$USER}

echo "=== docker 그룹 권한 적용을 위해 재로그인이 필요합니다 ==="

echo "=== 설치 완료 ==="
docker --version
systemctl status qemu-guest-agent --no-pager
