FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y xfce4 xfce4-goodies tightvncserver novnc websockify supervisor dbus-x11 xterm wget curl sudo && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && usermod -aG sudo ubuntu

RUN mkdir -p /home/ubuntu/.vnc

COPY xstartup /home/ubuntu/.vnc/xstartup

RUN chmod +x /home/ubuntu/.vnc/xstartup && chown -R ubuntu:ubuntu /home/ubuntu/.vnc

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-n"]
