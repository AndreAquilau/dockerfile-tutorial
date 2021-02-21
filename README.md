## Tutorial Docker File

#### Create File Dockerfile
> Dockerfile
```bash
touch Dockerfile
```
#### Commentary in DockerFile
```Dockerfile
# Comment inline
```
#### Instrução FROM
informa de qual imagem será gerada a nova imagem.
> FROM <image> [AS <name>] 
<br> OR

> FROM <image>[:tag] [AS <name>]
<br> OR

> FROM <image>[@<digest>] [AS <name>]
```Dockerfile
FROM ubuntu:latest
```
#### Instrução LABEL
Em uma instrução LABEL que adiciona meta-data para a sua imagem, é passado <br>
uma chave e valor entre aspas duplas.
> LABEL <key>=<value> <key>=<value> ...
```Dockerfile
FROM ubuntu:latest AS servidor

LABEL "version"="1.0.0" "description"="test"
```
##### LABEL MAINTAINER
É a pessoa que está mantendo a imagem atualizada.
```Dockerfile
FROM ubuntu:latest AS servidor  

LABEL "maintainer"="André Da Silva"
```    

#### Command DockerBuild
Comando usa para gerar a imagem a parti do Dockerfile.
```bash
$ sudo docker build . 

Sending build context to Docker daemon  58.88kB
 ---> 86c82deb7b22
Successfully built 86c82deb7b22
``` 
```bash
$ sudo docker image ls

REPOSITORY                    TAG       IMAGE ID       CREATED              SIZE
<none>                        <none>    86c82deb7b22   About a minute ago   72.9MB
```
##### Gerando imagem com nome e tag
> --tag, -t
```bash
$ sudo docker build --tag andreaquilau2021/ubuntu:latest .
```
```bash
$ sudo docker build --tag andreaquilau2021/ubuntu:latest
```
```bash
$ sudo docker image history 86c82deb7b22
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
## New Camada
86c82deb7b22   11 minutes ago   /bin/sh -c #(nop)  LABEL maintainer=André Aq…   0B        

f63181f19b2f   4 weeks ago      /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B        
<missing>      4 weeks ago      /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B        
<missing>      4 weeks ago      /bin/sh -c [ -z "$(apt-get indextargets)" ]     0B        
<missing>      4 weeks ago      /bin/sh -c set -xe   && echo '#!/bin/sh' > /…   811B      
<missing>      4 weeks ago      /bin/sh -c #(nop) ADD file:2a90223d9f00d31e3…   72.9MB 
```

