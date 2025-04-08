FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    openssh-server \
    sudo \
    passwd \
    curl \
    gnupg \
    ca-certificates \
    util-linux-extra \
    && apt-get clean \
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

RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb noble main" | tee /etc/apt/sources.list.d/redis.list

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]