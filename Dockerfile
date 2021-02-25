FROM ubuntu:latest

LABEL  "maintaner"="AndreAquilau"

RUN apt-get update

RUN apt-get install -y openssh-server vim curl git sudo

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'Banner /etc/banner' >> /etc/ssh/sshd_config

COPY etc/banner /etc/

RUN useradd -ms /bin/bash app

RUN adduser app sudo

RUN echo 'app:app' |chpasswd

USER app

RUN /bin/bash -l -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash"

RUN /bin/bash -l -c ". ~/.nvm/nvm.sh && nvm install 14.15.5"

USER root

EXPOSE 22

EXPOSE 3090

RUN /bin/bash -l -c "mkdir /workspace"

RUN /bin/bash -l -c "chmod 777 /workspace"

VOLUME /workspace

CMD    ["/usr/sbin/sshd", "-D"]