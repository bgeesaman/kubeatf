FROM alpine:3.6

RUN apk --update add sudo python py-pip openssl ca-certificates && \
    apk --update add --virtual build-dependencies python-dev       \
        libffi-dev openssl-dev build-base                       && \
    pip install pip cffi                                        && \
    pip install ansible==2.3.2.0                                && \
    apk del build-dependencies                                  && \
    rm -rf /var/cache/apk/*                                     && \
    mkdir -p /etc/ansible                                       && \
    echo 'localhost' > /etc/ansible/hosts

CMD [ "ansible-playbook", "--version" ]
