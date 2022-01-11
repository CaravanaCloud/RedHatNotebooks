FROM python:3.10

#RUN apt update -y && \ 
#    apt install jq curl unzip -y

RUN mkdir -p /tmp/rhnb  && \
    rm -rf /tmp/rhnb/awscliv2.zip  && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/rhnb/awscliv2.zip"  && \
    unzip -o -q /tmp/rhnb/awscliv2.zip -d /tmp/rhnb/  && \
    su -s "find /tmp/rhnb/"  && \
    su -s "/tmp/rhnb/aws/install --update"  && \
    rm -rf /tmp/rhnb/awscliv2.zip  

RUN pip install --no-cache notebook
ENV HOME=/tmp
### create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
