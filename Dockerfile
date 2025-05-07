# 使用 PostgreSQL 官方镜像作为基础
FROM postgres:16.8-bookworm

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-server-dev-16 \
    libxml2-dev \
    bison \
    flex \
    && rm -rf /var/lib/apt/lists/*

# 安装 pgvector
RUN git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make \
    && make install

# 安装 Apache AGE
RUN git clone https://github.com/apache/age.git /tmp/age \
    && cd /tmp/age \
    && git checkout release/PG16/1.5.0  \
    && PG_CONFIG=/usr/bin/pg_config make \
    && PG_CONFIG=/usr/bin/pg_config make install

# 复制初始化脚本
COPY init.sql /docker-entrypoint-initdb.d/