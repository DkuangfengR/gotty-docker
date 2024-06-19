# 使用官方的 Node.js 镜像作为基础镜像
FROM node:16-alpine

# 维护者信息
LABEL maintainer="1721878937@qq.com"

# 设置工作目录
WORKDIR /usr/src/app

# 安装 wetty
RUN npm install -g wetty

# 暴露端口
EXPOSE 10000

# 启动 wetty，并设置默认 SSH 目标为 localhost
CMD ["wetty", "--port", "10000", "--base", "/wetty", "--ssh-host", "localhost", "--ssh-user", "root"]
