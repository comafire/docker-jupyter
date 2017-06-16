# DataScientist 를 위한 Jupyter Docker 
데이터과학자를 위한 Jupyter 및 Spark 도커

현재 지원 기능 
* Jupyter
* Python 2, 3
** 기본 패키지들: numpy, pandas, sklearn ..
* PySpark

사전 요구사항
* Docker


## 설치 및 실행 

Docker 는 이미 설치되어 있다고 가정합니다.

Docker 설치가 필요하시면 Docker 공식 설치 문서를 참조하세요.
https://docs.docker.com/engine/installation/linux/ubuntu/

Github 에서 프로젝트를 Clone 합니다.

Docker Hub에서 이미지는 받으실수 있수 있기 때문에 로컬에서 docker 로 빌드하실 필요는 없습니다.

docker_run_jupyter.sh 를 실행하면 docker hub 에서 이미지를 다운로드 후 컨테이너가 실행 됩니다.

```
> git clone https://github.com/comafire/docker-jupyter.git
> cd docker-jupyter
> ./docker_run_jupyter.sh
``` 

docker ps 명령으로 컨테이너가 띄워져있는 것을 확인 하신 후
http://localhost:8888 에 접속 가능하시다면 설치가 완료된 것입니다.

기본 접속 암호는 notebook 입니다. 

## Jupyter 설정 변경 

Jupyter 암호/포트/작업디렉토리 변경은 docker_run_jupyter.sh 파일의 PASSWORD/PORT/VOLUME을 수정하시면 됩니다.

```
> vi docker_run_jupyter.sh

NAME="jupyter"
PORT="8888"
VOLUME=$(pwd)
PASSWORD="notebook"
...

``` 

## 추가 Python 패키지 설치

Python에 추가적으로 필요한 패키지는 requirements.txt 파일에 추가하시면 
Docker 기동시 해당 패키지를 설치하고 실행되기 때문에 Dockerfile 에 추가하고 이미지를
다시 필드하실 필요가 없습니다.

```
> vi requirements.txt

Flask<=0.12
pytest-flask<=0.10

...

```


