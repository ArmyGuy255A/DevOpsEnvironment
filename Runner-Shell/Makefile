.PHONY: build get-registration-token stop remove purge certificates env run up dev-up start fast-register register unregister


get-registration-token:
	# Get registration token from GitLab
	if ! grep -q REGISTRATION_TOKEN .env; then echo "REGISTRATION_TOKEN=$$(docker exec gitlab-gitlab-1 sh -c 'gitlab-rails runner -e production "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token"')" >> .env; fi

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

env:
	../Scripts/05-make-env-files.sh

run: certificates
	./run.sh

up: certificates get-registration-token
	docker compose up -d

start:
	docker compose start

fast-register:
	./register.sh runner-gitlab-runner-1

register: get-registration-token start
	./register.sh runner-gitlab-runner-1

unregister:
	docker exec exec runner-gitlab-runner-1 ./unregister.sh