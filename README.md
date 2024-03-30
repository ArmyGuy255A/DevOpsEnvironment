# Offine GitLab CI/CD

## URL's

All services are accessible by the host machine IP address and a specific port. The following are the URLs for the services:

| Service | URL |
| --- | --- |
| GitLab | https://x.x.x.x:8443 |
| Vault | https://x.x.x.x:8200 |
| KeyCloak | https://x.x.x.x:7443 |
| Harbor | https://10.X.10.2 |

## Usernames
1. GitLab: `root`
2. KeyCloak: `admin`
3. Harbor: `admin`
4. Vault: manual configuration required

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

# GitLab Fundamental Recommended Objectives

We tend to use GitLab for source control. It's important to note that you can store pretty much any type of file in this version control system. If you tend to store plaintext or raw text-based files on your filesystem, you should consider adding them to version control. The following are some recommended objectives to get you started with GitLab CI/CD:

### GitLab Tasks
- [ ] Create a new folder and initialize a new Git repository 
- [ ] Add a README.md file to the repository (sample provided below)
- [ ] Create a new blank project in GitLab (No README)
- [ ] Push your local repository to the blank project in GitLab
  - Often times we already have a bunch of files that we just need to get to GitLab
- [ ] Delete the local folder on your machine (Ensure you pushed the changes to GitLab)
- [ ] Clone the repository from GitLab to your local machine
- [ ] Create a new branch called `dev`
- [ ] Add/Update a README.md file for your project
- [ ] Push the changes to the `dev` branch
- [ ] Create a Pull Request into `main`
- [ ] Complete the Pull Request from `dev` to `main`
  
```markdown
# Welcome to the GitLab CI/CD Hackathon

# Quick Markdown Guide

Welcome to Markdown! Markdown is a lightweight markup language that you can use to add formatting elements to plaintext text documents. Here's how you can get started:

## Headings

Use `#` for headings. More `#`s mean a smaller heading.

# Heading 1
## Heading 2
### Heading 3
#### Heading 4

## Lists

- Item 1
- Item 2
  - Sub Item 2.1
  - Sub Item 2.2

1. First Item
2. Second Item
3. Third Item

## Links

[Google](https://www.google.com)

## Other Formatting

> This is a blockquote.
---

```

# Docker Recommended Objectives

Docker is what we use when building container images. This is the building block for containers. Master this and you will be able to build and deploy containers with ease! The following are some recommended objectives to get you started with Docker:

### Docker Tasks
- [ ] Create a new Dockerfile (working sample provided below)
- [ ] Build the Dockerfile
- [ ] Add a new tag to the Docker image
- [ ] Run the Docker image locally using a locally built Docker image
- [ ] Remove the Docker Image from the local machine
- [ ] Run the Docker Image locally using the Harbor image
- [ ] Create a docker-compose file to run the docker image

```Dockerfile
# Use the openjdk:17 image as the base image
FROM openjdk:17-slim-bullseye

# Set the Openfire version as a build argument
ARG OPENFIRE_VERSION=4_8_1
ENV OF_VERSION=${OPENFIRE_VERSION}

# Install tar and wget
RUN apt-get update && \
    apt-get install -y wget openssl vim nano && \
    apt-get clean

WORKDIR /usr/share

RUN wget https://igniterealtime.org/downloadServlet?filename=openfire/openfire_${OF_VERSION}.tar.gz

RUN mv download* openfire.tar.gz
RUN tar -xf openfire.tar.gz
RUN chmod 755 ./openfire
RUN rm openfire.tar.gz

# Add Plugins
# ADD Plugins /usr/share/openfire/plugins

#Admin Console
EXPOSE 9090
EXPOSE 9091

#Client to Server
EXPOSE 5222
EXPOSE 5223

#Server to Server
EXPOSE 5269
EXPOSE 5270

#Connection Manager
EXPOSE 5262

#HTTP Binding
EXPOSE 7070
EXPOSE 7443
EXPOSE 80
EXPOSE 443

#External Components
EXPOSE 5275
EXPOSE 5276 

#File Transfer
EXPOSE 7777

#TODO


# CMD [ "chown -R daemon:daemon ." ]

ENTRYPOINT [ "bash", "/usr/share/openfire/bin/openfire", "run" ]
```

# GitLab CI/CD Recommended Objectives

CI/CD Pipelines are a way to automate tasks that you would normally do manually. Suppose you do find yourself building docker images and having to push them to a container registry. Or, maybe you need to constantly make documentation and push it to a website. You can use tools like LaTeX to automate the generation of PDFs and push them to a website. You can run remote scripts on servers. You can rotate passwords in a password manager. The possibilities are endless! The following are some recommended objectives to get you started with GitLab CI/CD:

### GitLab CI/CD Tasks
- [ ] Create a new CI/CD pipeline, or .gitlab-ci.yml file for a git repository
- [ ] Make the CI/CD pipeline only on the `dev` branch
- [ ] Build the Docker image in the CI/CD pipeline
- [ ] Push the Docker image to the GitLab registry
- [ ] Push the Docker image to the Harbor registry
- [ ] Create Unit Tests for PowerShell Scripts (Pester)
- [ ] Generate a PDF of this Markdown file using LaTeX and add it as an artifact to the repository
- [ ] Use a Harbor Image in a CI/CD pipeline (Dind Runner)
- [ ] Use tags in the CI/CD pipeline to target specific runners (Shell vs Dind)
- [ ] Register a new CI/CD runner (Stretch Goal. Ask your mentor for help with deploying a new runner.)

# Harbor Recommended Objectives

Harbor is a great tool for making your Docker Images available to other services on a network. It's also one of your only options in an air-gapped environment. It's very simple to grab containers from Docker Hub or any other registry and push them to Harbor. You can also do things like store those container images in indivual .tar.gz files so you can easily move them around. The following are some recommended objectives to get you started with Harbor:

### Container Registry (Harbor) Tasks
- [ ] Create a new project in Harbor
- [ ] Login to Harbor using the Docker CLI
- [ ] Pull an image from Docker Hub: armyguy255a/openfire:latest
- [ ] Tag a local image for Harbor
- [ ] Push the local image to Harbor
- [ ] Push the local image to Harbor
- [ ] Export an image to a .tar.gz file
- [ ] Import an image from a .tar.gz file

# Vault Recommended Objectives

Azure Key Vault and AWS Secrets Manager are great tools for managing secrets. But, did you know that you can use Hashicorp Vault to manage your secrets just like Azure Key Vault and AWS Secrets Manager? The following are some recommended objectives to get you started with Vault:

### Vault Tasks
- [ ] Create a new secret in Vault
- [ ] Create a new policy in Vault
- [ ] Create a new token in Vault
- [ ] Retrieve secrets from Vault in a CI/CD pipeline
- [ ] Update the secret in Vault using a CI/CD pipeline

# KeyCloak Recommended Objectives

KeyCloak is a very robust Identity Provider (IdP) that can be used to manage your users and groups. It's also a greay way to break away from using Active Directory for Identity and Credential Access Management. The entire lab environment uses common SSL certificates, so integrating all of your services should be very straightforward! The following are some recommended objectives to get you started with KeyCloak:

### KeyCloak Tasks
- [ ] Integrating KeyCloak with GitLab
- [ ] Integrate KeyCloak with Vault
- [ ] Integrate KeyCloak with Sitaware HQ
- [ ] Integrate KeyCloak with vCenter (Stretch Goal. Ask your mentor for help with deploying a new vCenter server.)
- [ ] Integrate KeyCloak with ADFS (Stretch Goal. Ask your mentor for help with deploying a new ADFS server.)
- [ ] Integrate KeyCloak with Harbor (Stretch Goal. Ask your mentor for help with deploying a new Harbor registry.)

# Packer Recommended Objectives

Packer is a tool that is used for building baseline machine images. It's a great way to standardize your baselines and ensure that all of your machines are built in a consistent way. You can use Packer to build images locally, or you can use CI/CD pipelines to build images centrally. This allows teams to contribute to the image building process. The following are some recommended objectives to get you started with Packer:

### Packer Tasks
- [ ] Create a new Packer template
- [ ] Use the Azure Provider
- [ ] Use the vSphere ISO provider
- [ ] Deploy a packer image to Azure
- [ ] Deploy a packer image to vSphere

# Terraform Recommended Objectives

Terraform is a tool that is used for building infrastructure as code (IaC). It's a way to standardize your infrastructure and ensure that all of your environments conform to a standard. You can give your terraform templates to other teams and they can deploy their own environments, just like docker-compose files and helm charts. While helm and docker-compose are great for deploying applications and microservices. Those microservices need a platform to run on. This is where Terraform comes in. You would deploy your infrastructure with Terraform, and then deploy your applications with Helm or Docker Compose. The following are some recommended objectives to get you started with Terraform:

### Terraform Tasks
- [ ] Create a new Terraform template
- [ ] Deploy a new VM to Azure
- [ ] Deploy a new VM to vSphere

