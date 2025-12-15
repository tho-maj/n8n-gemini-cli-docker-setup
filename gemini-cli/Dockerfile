FROM node:24-bookworm-slim
# Node 24 LTS Basis. [web:194]

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server ca-certificates \
 && rm -rf /var/lib/apt/lists/*
# Installiert sshd in einem Debian-basierten Image. [web:278]

RUN useradd -m -s /bin/bash gemini \
 && usermod -p '*' gemini \
 && mkdir -p /home/gemini/.ssh /var/run/sshd \
 && chown -R gemini:gemini /home/gemini/.ssh \
 && chmod 700 /home/gemini/.ssh
# User + SSH-Verzeichnis. [web:278]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh && chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

COPY sshd_config /etc/ssh/sshd_config
# SSH-Config ins Image. [web:278]

EXPOSE 22
CMD ["/usr/sbin/sshd","-D","-e"]
# Startet sshd im Foreground, damit der Container läuft. [web:278]
