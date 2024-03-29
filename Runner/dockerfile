FROM gitlab/gitlab-runner:ubuntu-v16.10.0

LABEL Author="Phil Dieppa"
LABEL Email="mrdieppa@gmail.com"
LABEL BaseImage="gitlab/gitlab-runner"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget unzip ca-certificates

RUN wget -q https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -O /tmp/vault.zip && \
    unzip /tmp/vault.zip -d /bin && \
    rm /tmp/vault.zip

ADD scripts/unregister.sh /unregister.sh
ADD entrypoint /entrypoint
RUN chmod +x /entrypoint /unregister.sh

STOPSIGNAL SIGQUIT
VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]