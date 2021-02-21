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

