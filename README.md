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

#### Instrução RUN
É um comando que roda em um shell.
```Dockerfile
FROM ubuntu:latest AS servidor  

LABEL "maintainer"="AndréAquilau" "version"="1.0.0" "description"="servidor linux ubuntu"

#Camada 1
RUN apt-get update && apt-get upgrade && apt install curl
```

#### Instrução EXPOSE and CMD
A instrução EXPOSE informa ao docker ficar escutando determinada porta.
> EXPOSE <port>

<br>

A instrução CMD é utilizada para passar um comando a ser executado <br>
assim que o container for iniciado.
<br>

> CMD /bin/bash or CMD ["/bin/bash"] 

```Dockerfile
FROM       ubuntu:latest
LABEL  "Aleksandar Diklic"="https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
EXPOSE 3090

CMD    ["/usr/sbin/sshd", "-D"]
```

#### Instrução ADD 
A instrução ADD serve para copiar novos arquivos e diretorios <br>
ou arquivos de alguma url para dentro da imagem.
```Dockerfile
COPY [--CHOWN=<USER>:GROUP] <src>...<dest>
```
#### Instrução COPY 
A instrução COPY faz básicamente a mesma coisa que o ADD, copia arquivos ou diretorios <br>
para dentro da imagem. 
```Dockerfile
COPY [--CHOWN=<USER>:GROUP] <src>...<dest>
```
##### Diferença entre COPY e ADD
A diferença é que o COPY copia da máquina local recebendo uma origem <br>
e passando também um destino para dentro da imagem. Já o ADD copia arquivos de url.
```Dockerfile   
FROM       ubuntu:latest

LABEL  "maintaner"="AndreAquilau"

RUN apt-get update

RUN apt-get install -y openssh-server vim

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'Banner /etc/banner' >> /etc/ssh/sshd_config

COPY etc/banner /etc/

EXPOSE 22

EXPOSE 3090

CMD    ["/usr/sbin/sshd", "-D"] # OR CMD  /usr/sbin/sshd && -D
```
#### Instrução USER
Indica qual usuário está rodando os comandos RUN and CMD. <br>
Quando o usuário não é indentificado é rodado como ROOT.
```Dockerfile   
FROM       ubuntu:latest

LABEL  "maintaner"="AndreAquilau"

RUN apt-get update

RUN apt-get install -y openssh-server vim

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'Banner /etc/banner' >> /etc/ssh/sshd_config

COPY etc/banner /etc/

# "useradd" cria um usuário, "-ms" define a pasta home do usuário e qual seu irá usar. 
RUN useradd -ms /bin/bash app

# "adduser" app sudo adiciona o comando sudo ao usuário
RUN adduser app sudo

# "echo" printa o user:password ao chpasswd => fica as senhas dos usuários
RUN echo 'app:app' |chpasswd

# Altera para o usuário app
USER app

# Install NVM  "/bin/bash -l -c" => força o comando a ser rodado com bash
RUN /bin/bash -l -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash"
RUN /bin/bash -l -c ". ~/.nvm/nvm.sh && nvm install nvm install 14.15.5 && nvm use 14.15.5"

# Altera para o usuário ROOT
USER root

# Expõe as portas 
EXPOSE 22

EXPOSE 3090

# Comando executado quando a imagem for rodada
CMD    ["/usr/sbin/sshd", "-D"] # OR CMD  /usr/sbin/sshd && -D
```
#### Referemces
[Graffiti Display Type](atorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20)