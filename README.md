# Offine GitLab CI/CD

## URL's

1. GitLab: [https://x.x.x.x:8443](http://localhost:8080)
2. VS Code Server: [http://x.x.x.x:8080](http://localhost:8080)
3. Harbor: [http://10.x.10.2](https://10.x.10.2)

## Usernames
1. GitLab: `root`
2. KeyCloak: `admin`
3. Harbor: `admin`

# Getting Started

## Lab Environment (VM Provided)
Running the make command will initialize a new environment with all the necessary prerequisites. Ensure this is running on a Debian based system. 

`make lab` - This will generate new Server and Environment variable files and launch the lab environment
`make purge` - This will remove all the containers and the volumes
`make stop` - This will stop all the containers
`make start` - This will start all the containers

### Fresh Environment (Only if cloned)
`make install-prerequisites` - This will install all the necessary prerequisites
`make fresh` - This will generate new CA certificates and launch the lab environment
