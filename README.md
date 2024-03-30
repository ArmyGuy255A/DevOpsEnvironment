# Offine GitLab CI/CD

## URL's

All services are accessible by the host machine IP address and a specific port. The following are the URLs for the services:

| Service | URL |
| --- | --- |
| GitLab | https://x.x.x.x:8443 |
| Vault | https://x.x.x.x:8200 |
| KeyCloak | https://x.x.x.x:7443 |
| Harbor | https://10.X.10.2 |

1. GitLab: [https://x.x.x.x:8443](http://localhost:8080)
2. VS Code Server: [http://x.x.x.x:8080](http://localhost:8080)
3. Harbor: [http://10.x.10.2](https://10.x.10.2)
4. Vault: [http://10.x..3](https://10.x.10.3)

## Usernames
1. GitLab: `root`
2. KeyCloak: `admin`
3. Harbor: `admin`

# Getting Started

If you cloned this repository, you will need to install the prerequisites and generate a new CA Certificate. Use the commands highlighted in the Fresh Environment section. If you are using the VM provided, you can skip this step. Some benefits of using this environment is that it is self-contained, yet is still accessible from an external network. This lab environment is ready for a small scale development team to use for their projects. 

### Fresh Environment (Only if cloned)
`make install-prerequisites` - This will install all the necessary prerequisites
`make fresh` - This will generate new CA certificates for a specified domain and launch the lab environment

### Lab Environment (VM Provided)
Running the make command will initialize a new environment with all the necessary prerequisites. Ensure this is running on a Debian based system. 

`make lab` - This will generate new Server and Environment variable files and launch the lab environment
`make purge` - This will remove all the containers and the volumes. This will reset the entire environment and is not recoverable
`make stop` - This will stop all the containers
`make start` - This will start all the containers

Making the lab environment requires a lot of steps that has been automated using a Makefile. The benefits of using Makefiles are that they are easy to read and understand, and they can be used to automate repetitive tasks. Please examile the Makefiles throughout the entire project to understand the manual steps that would have been required to setup the environment. You should come to appreciate the power of automation and how it can save you time and effort.

# GitLab CI/CD Recommended Objectives

We tend to use GitLab CI/CD for our projects.