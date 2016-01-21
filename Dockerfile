FROM cloud9/workspace

USER ubuntu

RUN curl -L https://raw.githubusercontent.com/c9/install/master/install.sh | bash
RUN cd /home/ubuntu && git clone https://github.com/fjakobs/geekdots.git workspace

USER root

RUN apt-get install -y dropbear

EXPOSE 22 80 443 8080

CMD bash -c '\
    echo "$SSH_PUB_KEY" >> /home/ubuntu/.ssh/authorized_keys; \
    chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys; \
    /usr/sbin/dropbear -F -E -m -w -s -d /etc/dropbear/dropbear_dss_host_key -r /etc/dropbear/dropbear_rsa_host_key'