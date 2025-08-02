# development_setup

개인 개발환경 setup
각 커맨드를 통해 환경을 설정할 수 있습니다.

### Basic
```
# 아래와 같은 명령어로 실행
sh development.sh basic
```

| 파일이름 | 용도  | 사용 예시 |
|---|---|---|
| development.sh  | brew 및 기타 필요 툴을 다운로드 설치하는 용도  | sh development.sh basic|
| brew_file.sh  | homebrew 및 brewfile 기준으로 필요한 툴을 다운로드 설치하는 용도  | sh brew_file.sh |
| local_ssl.sh  | 로컬에서 ssl 인증이 필요한 경우 사용  | sh local_ssl.sh |

### development.sh 의 install 리스트

Basic
├── brew
├── git
├── zsh
├── pre-commit
├── tfenv
├── awscli
├── docker
├── table_plus
├── python@3.10
├── pipenv
├── docker
├── rectangle
└── rbenv
    └── ruby 3.1.2

```

setup 목록들은 설치 및 해당하는 명령어가 비슷한 것 끼리 각각 분류되고 필요할 때마다 업데이트 됩니다.
