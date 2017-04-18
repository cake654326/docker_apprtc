FROM ubuntu:16.04

MAINTAINER preluoc "pre_luoc@sina.com"

USER root

#修改阿里源
RUN  cp /etc/apt/sources.list /etc/apt/sources.list.bak

ADD  sources.list /etc/apt/

#升级apt
RUN  apt update

#安装git
RUN  apt install -y git

#自启动服务

RUN  apt install -y supervisor

COPY supervisord.conf /etc/supervisord/conf.d/supervisord.conf

RUN  mkdir -p /var/log/supervisor

# room 服务器

RUN  apt install -y nodejs

RUN  apt install -y npm

RUN  npm install -g npm

RUN  apt install -y nodejs-legacy

RUN  npm -g install grunt-cli

RUN  apt install -y unzip

RUN  apt install -y python-webtest

ADD  google_appengine_1.9.52.zip /root/

WORKDIR /root/

RUN  unzip google_appengine_1.9.52.zip

RUN  echo "PATH='$PATH:/root/google_appengine/'" >> /etc/profile

RUN  git clone https://github.com/webrtc/apprtc.git

#ADD  roomserver_init.sh /root/

#RUN  chmod u+x /root/roomserver_init.sh

#RUN  /root/roomserver_init.sh

# 信令服务器

RUN  apt install -y golang-go

RUN  apt install -y mercurial

ADD  golang.org.x.net.tar.gz /root/

#ADD  collider_init.sh /root/

#RUN  chmod u+x /root/collider_init.sh

#RUN  /root/collider_init.sh


# TURN STUN 服务器



# 添加运行时脚本

ADD  entrypoint.sh /bin/

RUN  chmod 755 /bin/entrypoint.sh

CMD  ["/usr/bin/supervisord"]

ENTRYPOINT /bin/entrypoint.sh
