.PHONY: stop down purge certificates up

stop:
	docker compose stop

down:
	docker compose down

env:
	../Scripts/05-make-env-files.sh

purge:
	docker compose down -v
	sudo rm -rf volumes

certificates:
	cd ../Scripts && \
	./30-move-certs.sh
	./make-keystore.sh
	./add-certs-to-keystore.sh
	rm ./volumes/truststores/ca.crt ./volumes/truststores/server.crt ./volumes/truststores/server.key

up: certificates
	docker compose up -d
