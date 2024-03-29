.PHONY: install-prerequisites variables ca-certs certs setup start-gitlab stop-gitlab start-runner stop-runner start-keycloak stop-keycloak start-vault stop-vault stop start lab fresh purge

install-prerequisites:
	sudo find . -name *.sh -exec chmod +x {} + && \
	cd Scripts && \
	sudo ./00-install-prerequisites.sh

variables:
	cd Scripts && \
	./05-make-env-files.sh

ca-certs:
	cd Scripts && \
	./10-make-ca-certs.sh

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

start-runner:
	cd Runner && \
	make up

stop-runner:
	docker compose -f ./Runner/docker-compose.yml stop

start-keycloak:
	docker compose -f ./KeyCloak/docker-compose.yml up -d

stop-keycloak:
	docker compose -f ./KeyCloak/docker-compose.yml stop

start-vault:
	docker compose -f ./Vault/docker-compose.yml up -d

stop-vault:
	docker compose -f ./Vault/docker-compose.yml stop

stop: stop-gitlab stop-runner stop-keycloak stop-vault

start: start-gitlab start-runner start-keycloak start-vault start-runner

lab: setup start-gitlab start-vault start-keycloak 
	# Wait 5 minutes for the services to start, tuen start the runner
	echo "Waiting for services to start... Then, registering a runner"
	echo "This will take about 5 minutes. Go grab a coffee!"
	sleep 300
	make start-runner

# Only run 'all' if you have cloned the repository. This will rotate all of the CA certificates and generate new server certificates.
fresh: ca-certs lab

purge:
	docker compose -f ./GitLab/docker-compose.yml down -v
	docker compose -f ./Runner/docker-compose.yml down -v
	docker compose -f ./KeyCloak/docker-compose.yml down -v
	docker compose -f ./Vault/docker-compose.yml down -v
	# remove all instance data
	sudo find . -type d -name 'volumes' -exec rm -rf {} +
	sudo find . -name '.env' -exec rm -rf {} +

docker-clean:
	docker system prune -a --volumes --force
