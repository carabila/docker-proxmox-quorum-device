FROM debian:buster-slim

ENV PASSWD 'securepassword'
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y corosync-qnetd openssh-server

ADD ./scripts/start.sh /start.sh

# enable root password for ssh login
RUN echo "root:$PASSWD" | chpasswd
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN chmod 755 /start.sh

# generate host ssh keys
#RUN ssh-keygen -A

# magic command
RUN service ssh start
RUN service corosync-qnetd start

# launch sshd as daemon
#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
CMD ["/bin/bash", "/start.sh"]
