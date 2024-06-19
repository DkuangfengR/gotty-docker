# 使用官方的 Alpine Linux 镜像作为基础镜像
FROM alpine:latest

# 安装必要的软件包
RUN apk add --no-cache bash curl

# 安装 Gotty 并添加执行权限
RUN curl -LO https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    chmod +x /usr/local/bin/gotty && \
    rm gotty_linux_amd64.tar.gz

# 创建一个新的用户
RUN adduser -D -s /bin/bash user

# 设置工作目录
WORKDIR /home/user

# 切换到非root用户
USER user

# 暴露 Gotty 默认的端口
EXPOSE 8080

# 启动 Gotty
CMD ["ls", "-al", "/usr/local/bin", "bash"]
