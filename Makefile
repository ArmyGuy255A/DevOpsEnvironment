.PHONY: certs

variables:
	./Scripts/05-make-env-files.sh

certs:
	./Scripts/20-make-server-certs.sh
	./Scripts/30-move-certs.sh
	
setup: variables certs
	echo "Setup complete"