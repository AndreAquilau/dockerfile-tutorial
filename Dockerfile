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

CMD    ["/usr/sbin/sshd", "-D"]