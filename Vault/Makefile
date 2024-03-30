.PHONY: stop down purge certificates up

stop:
	docker compose stop

down:
	docker compose down

purge:
	docker compose down -v
	sudo rm -rf volumes

certificates:
	cd ../Scripts && \
	./30-move-certs.sh

up: certificates
	# Move the configuration files to the correct location
	cp ./config/vault.json ./volumes/config/vault.json
	docker compose up -d
