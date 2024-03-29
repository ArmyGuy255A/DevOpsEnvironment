.PHONY: stop up up-debug purge certificates follow dev-run

stop:
	docker compose stop

up: certificates
	docker compose up -d

up-debug: certificates
	docker compose up

purge:
	docker compose down -v
	sudo rm -rf volumes

certificates:
	cd ../Scripts && ./30-move-certs.sh

follow:
	docker logs -f gitlab-gitlab-1
	
dev-run: purge certificates start follow
	docker logs -f gitlab-gitlab-1
