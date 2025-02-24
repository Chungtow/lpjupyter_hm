# 使用基础镜像
FROM quay.io/jupyterhub/jupyterhub:5.2.1
LABEL maintainer="moweng<changtao86@163.com>"

# 安装vim和jupyterlab-language-pack-zh-CN插件
RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y sqlite3 && \
    pip install notebook --upgrade -i https://mirrors.aliyun.com/pypi/simple && \
    pip install jupyterlab-language-pack-zh-CN -i https://mirrors.aliyun.com/pypi/simple && \
    pip install jupyter_scheduler==2.10.0 -i https://mirrors.aliyun.com/pypi/simple

# 生成默认的jupyterhub配置文件
RUN mkdir -p /srv/jupyterhub && \
    jupyterhub --generate-config -f /srv/jupyterhub/jupyterhub_config.py
    
# 复制准备好的额外配置文件，并追加到生成的配置文件中
COPY jupyterhub_config.txt /tmp/jupyterhub_config.txt
RUN cat /tmp/jupyterhub_config.txt >> /srv/jupyterhub/jupyterhub_config.py && \
    rm /tmp/jupyterhub_config.txt

# 复制事先准备好的/start.sh脚本并设置可执行权限
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 暴露必要的端口
EXPOSE 8000 

# 设置容器启动时执行/start.sh脚本
CMD ["/start.sh"]
