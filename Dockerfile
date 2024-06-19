# 使用官方的 Alpine Linux 镜像作为基础镜像
FROM alpine:latest

# 安装必要的软件包
RUN apk add --no-cache bash curl

# 安装 Gotty
RUN curl -LO https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz && \
    tar -xzf gotty_linux_amd64.tar.gz && \
    mv gotty /usr/local/bin/ && \
    chmod +x /usr/local/bin/gotty && \
    rm gotty_linux_amd64.tar.gz

# 暴露 Gotty 默认的端口
EXPOSE 10000

# 启动 Gotty
CMD ["gotty", "-w", "-p", "10000", "bash"]
