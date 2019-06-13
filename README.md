## atlantis-ansible-dokcer

[![CircleCI](https://circleci.com/gh/guitarrapc/atlantis-ansible-dokcer.svg?style=svg)](https://circleci.com/gh/guitarrapc/atlantis-ansible-dokcer) [![](https://images.microbadger.com/badges/image/guitarrapc/atlantis-ansible-dokcer.svg)](https://microbadger.com/images/guitarrapc/atlantis-ansible-dokcer "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/guitarrapc/atlantis-ansible-dokcer.svg)](https://microbadger.com/images/guitarrapc/atlantis-ansible-dokcer "Get your own version badge on microbadger.com")

docker image for atlantis docker with ansible support.

**Base Image**

> https://hub.docker.com/r/runatlantis/atlantis/

Base Dockerfile

> https://github.com/runatlantis/atlantis/blob/master/Dockerfile

**GitHub**

> https://github.com/runatlantis/atlantis

## atlantis and ngrok docker-compose sample.

boot atlantis and ngrok.
atlantis contains ansible and aws credential.
Also azure credential will be pass via env_file `atlantis.env`.

host directory tree

```
├── ansible
├── atlantis.env
├── atlantis.yaml
├── terraform // both aws and azure supported
└── docker-compose.yml
```

docker-compose sample

```docker-compose.yaml
version: "2"
services:
  atlantis:
    container_name: atlantis
    restart: always
    image: "guitarrapc/atlantis-ansible-dokcer"
    volumes:
      - ~/.ssh:/home/atlantis/.ssh
      - ~/.aws:/home/atlantis/.aws
      - ~/.ansible:/home/atlantis/.ansible
      - ${PWD}/ansible/playbooks/ansible.cfg:/home/atlantis/.ansible.cfg:rw
    ports:
      - 4141:4141
    env_file:
      - ./atlantis.env
  ngrok:
    container_name: ngrok
    image: "wernight/ngrok"
    volumes:
      - ~/.ngrok2/:/home/ngrok/.ngrok2/
    ports:
      - "0.0.0.0:4040:4040"
    links:
      - atlantis
    environment:
      - NGROK_PORT=atlantis:4141
```
