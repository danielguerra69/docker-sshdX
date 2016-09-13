FROM danielguerra/docker-sshd
# docker ssh front docker is based on alpine
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>

ADD apk /apk
RUN cp /apk/.abuild/-57d704f1.rsa.pub /etc/apk/keys
RUN apk --update add /apk/ossp-uuid-1.6.2-r0.apk
RUN apk add /apk/ossp-uuid-dev-1.6.2-r0.apk
RUN apk add /apk/x11vnc-0.9.13-r0.apk
RUN apk add xvfb supervisor xfce4-terminal openbox util-linux dbus ttf-freefont\
    && rm -rf /apk /tmp/* /var/cache/apk/*
ADD etc /etc
ADD bin/* /usr/local/bin/
ENV DISPLAY=:0
ENTRYPOINT ["docker-entrypoint.sh"]
#start sshd
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
