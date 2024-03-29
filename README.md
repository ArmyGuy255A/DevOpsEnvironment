# Offine GitLab CI/CD



## URL's

1. GitLab: [https://x.x.x.x:8443](http://localhost:8080)
2. VS Code Server: [http://x.x.x.x:8080](http://localhost:8080)

## Passwords
1. GitLab: `root` / `1qa@WS3ed$RF5tg`

# Getting Started

## Generating Certificates

If this machine has been provided to you, it is likely that the root certificates have already been generated. If not, you can generate them by running the following command:

### Certificate Authority
```bash
    ./10-make-ca-certs.sh
```

### Server Certificates

Each machine will likely have a different hostname, so you will need to generate the server certificates for the machine you are on. You can do this by running the following command:
```bash
    ./20-make-server-certs.sh
```

### Moving Certificates

There are quite a few locations that need the certificates once they're generated. Luckily, the CA certificate can be used to all of the client communication. So, we'll need to just move the individual server certificates to the correct locations where they'll be consumed by the respective docker services.
```bash
    ./30-move-certs.sh
```

## Starting the Containers

This environment has been setup to run an integrated CI/CD environment. This includes a GitLab server, a Runner, a VS Code Server, a K3s cluster, a Harbor Registry, and a KeyCloak server. To start the environment, you can run the following command:
```bash
    docker-compose up -d
```

Optionally, each service can be started individually by running the docker compose command in the respective folder.

### Gitlab Information

1. g

##Manually Building
1. Clone the repository: 
```bash
    git clone <repository>
```
Navigate into the root of the repository.
```bash
    cd <GitLab>
```

1. Make the CA certificates
1. Make the server certificates
1. Move the certificates to the correct stores
1. Start the containers
1. Register the runner
# DevOpsEnvironment
