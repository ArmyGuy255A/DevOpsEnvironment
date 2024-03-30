.PHONY: install-prerequisites variables ca-certs certs setup start-gitlab stop-gitlab start-runner-dind stop-runner-dind start-runner-shell stop-runner-shell start-keycloak stop-keycloak start-vault stop-vault stop start domain ssh git-config git-phil lab fresh iptables purge docker-clean

install-prerequisites:
	find . -name *.sh -exec chmod +x {} + && \
	cd Scripts && \
	./00-install-prerequisites.sh

variables:
	cd Scripts && \
	./05-make-env-files.sh

ca-certs:
	cd Scripts && \
	sudo ./10-make-ca-certs.sh

certs:
	cd Scripts && \
	./20-make-server-certs.sh && \
	./30-move-certs.sh
	
setup: variables certs
	echo "Setup complete"

start-gitlab:
	docker compose -f ./GitLab/docker-compose.yml up -d

stop-gitlab:
	docker compose -f ./GitLab/docker-compose.yml stop

start-runner-dind:
	cd Runner-Dind && \
	make up

stop-runner-dind:
	docker compose -f ./Runner-Dind/docker-compose.yml stop

start-runner-shell:
	cd Runner-Shell && \
	make up

stop-runner-shell:
	docker compose -f ./Runner-Shell/docker-compose.yml stop

start-keycloak:
	cd KeyCloak && \
	make up

stop-keycloak:
	docker compose -f ./KeyCloak/docker-compose.yml stop

start-vault:
	cd Vault && \
	make up

stop-vault:
	docker compose -f ./Vault/docker-compose.yml stop

stop: stop-gitlab stop-keycloak stop-vault stop-runner-dind stop-runner-shell

start: start-gitlab start-keycloak start-vault start-runner-dind start-runner-shell

domain:
	# Get the domain name
	ip addr show ens192 | grep "inet " | awk '{print $$2}' | cut -d/ -f1

ssh: 
	# Generate a new SSH key pair
	rm ~/.ssh -rf
	ssh-keygen -t rsa -b 4096 -C "toor@$$(ip addr show ens192 | grep "inet " | awk '{print $$2}' | cut -d/ -f1)" -N "" -f ~/.ssh/id_rsa

git-config:
	# Setup the git config for Git
	git config --global user.email "toor@$$(ip addr show ens192 | grep "inet " | awk '{print $$2}' | cut -d/ -f1)"
	git config --global user.name "toor"

git-phil:
	# Setup the git config for Git
	git config --global user.email "mrdieppa@gmail.com"
	git config --global user.name "Phil Dieppa"

lab: ssh git-config setup start-gitlab start-vault start-keycloak
	# Waiting for services to start... Then, registering a runner
	# This will take about 5 minutes. Feel free to keep working. The runners will self-register when they're ready.
	(sleep 300; make start-runner-dind; make start-runner-shell) &

# Only run 'all' if you have cloned the repository. This will rotate all of the CA certificates and generate new server certificates.
fresh: ca-certs lab

iptables:
	# Flush the IPTABLES
	sudo iptables -F
	sudo systemctl restart docker
	sudo systemctl restart k3s
	sleep 5
	sudo iptables -L
	
purge:
	# Remove all environment variable data
	sudo find . -name '.env' -exec rm -rf {} +
	docker compose -f ./GitLab/docker-compose.yml down -v
	docker compose -f ./Runner-Dind/docker-compose.yml down -v
	docker compose -f ./Runner-Shell/docker-compose.yml down -v
	docker compose -f ./KeyCloak/docker-compose.yml down -v
	docker compose -f ./Vault/docker-compose.yml down -v
	# remove all instance data
	sudo find . -type d -name 'volumes' -exec rm -rf {} +
	# remove all user ssh data
	rm ~/.ssh -rf
	# log out of all git sessions
	git credential-cache exit
	rm ~/.gitconfig -f
	make iptables
	make git-config
	rm ~/.vscode-server/data/User/History/* -fdr

docker-clean:
	docker system prune -a --volumes --force

clean: purge docker-clean