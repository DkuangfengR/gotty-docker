# 使用官方的 Golang 镜像作为构建阶段的基础镜像
FROM golang:1.18 AS builder

# 设置工作目录
WORKDIR /build

# 下载 Gotty 源代码
RUN go install github.com/yudai/gotty@latest

# 创建最终镜像
FROM alpine:latest

# 安装必要的软件包
RUN apk add --no-cache bash curl

# 从构建阶段复制 Gotty 二进制文件到最终镜像
COPY --from=builder /go/bin/gotty /usr/local/bin/

# 创建一个新的用户
RUN adduser -D -s /bin/bash user

# 设置工作目录
WORKDIR /home/user

# 切换到非root用户
USER user

# 暴露 Gotty 默认的端口
EXPOSE 10000

# 启动 Gotty
CMD ["gotty", "-w", "-p", "10000", "bash"]
