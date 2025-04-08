FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    openssh-server \
    sudo \
    passwd \
    util-linux-extra \
    && rm -rf /var/lib/apt/lists/*

# Create SSH run directory
RUN mkdir /var/run/sshd

# Accept build-time password for root
ARG ROOT_PASSWORD
ARG SPINUPWP_SSH_KEY

# Set root password
RUN echo "root:${ROOT_PASSWORD}" | chpasswd

# Configure SSH
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config

RUN printf "\n${SPINUPWP_SSH_KEY}" >> ~/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]