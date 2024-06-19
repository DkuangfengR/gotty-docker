# 使用官方的 Ubuntu 镜像作为基础镜像
FROM ubuntu:20.04

# 维护者信息
LABEL maintainer="your-email@example.com"

# 环境变量设置
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的包
RUN apt-get update && \
    apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    wget \
    supervisor \
    net-tools \
    xterm \
    sudo \
    && apt-get clean

# 安装 noVNC
RUN mkdir -p /opt/novnc/utils/websockify && \
    wget -qO- https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz | tar xz --strip 1 -C /opt/novnc && \
    wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/novnc/utils/websockify

# 创建 VNC 用户并设置密码
RUN useradd -m FrancisLiu && \
    echo 'FrancisLiu:c23b1775954b7dbc5dbf9ca40f47e20a' | chpasswd && \
    mkdir -p /home/FrancisLiu/.vnc && \
    echo "c23b1775954b7dbc5dbf9ca40f47e20a" | vncpasswd -f > /home/FrancisLiu/.vnc/passwd && \
    chown -R FrancisLiu:FrancisLiu /home/FrancisLiu && \
    chmod 600 /home/FrancisLiu/.vnc/passwd

# 将用户FrancisLiu添加到sudoers
RUN echo 'FrancisLiu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# 配置 supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 暴露端口
EXPOSE 10000

# 启动 supervisord
CMD ["/usr/bin/supervisord"]
