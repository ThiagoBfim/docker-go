
## Go with Docker

Projeto do Full Cycle Developer [https://portal.code.education/](https://portal.code.education/) com objetivo de criar um endpoint em Go,
e disponibilizar por meio de uma imagem docker com no máximo 2MB.

## Desenvolvimento

```
docker build -t desafio-go-dev -f Dockerfile-dev .
docker run --network desafio --name desafio-go-dev -p8000:8000 -v $(pwd)/app:/usr/src/app desafio-go-dev
```

## PROD

```
docker run --name desafio-go -p8000:8000 thiagobfim/codeeducation
```

Acessar: http://localhost:8000/
