# HashiCorp Vault

HashiCorp Vault is a popular open-source tool for securely managing secrets and sensitive data in modern cloud-native applications. It provides a centralized platform for storing, accessing, and managing secrets such as API keys, passwords, certificates, and database credentials.

## Key Features

- **Secret Management**: Vault allows you to securely store and manage secrets, ensuring that sensitive information is protected.
- **Dynamic Secrets**: Vault can generate dynamic secrets on-demand for various systems, reducing the risk of secrets being compromised.
- **Encryption as a Service**: Vault provides encryption as a service, allowing you to encrypt and decrypt data without exposing encryption keys.
- **Access Control**: Vault offers fine-grained access control policies, enabling you to define who can access which secrets.
- **Auditing and Logging**: Vault keeps a detailed audit log of all secret access and management activities, providing visibility and accountability.

## Getting Started

To get started with HashiCorp Vault, you can follow the official documentation and guides available on the [HashiCorp website](https://www.vaultproject.io/). The documentation provides step-by-step instructions for installation, configuration, and usage of Vault.

## Certs

```bash
# Copy certs for Vault
cp ca.crt ./volumes/config/ca.crt
cp server.crt ./volumes/config/server.crt
cp server.key ./volumes/config/server.key
```
## Running

Just docker compose up!

```bash
docker-compose up -d
```

## Contributing

If you would like to contribute to HashiCorp Vault, please refer to the [contribution guidelines](https://github.com/hashicorp/vault/blob/main/CONTRIBUTING.md) provided by the project.

## License

HashiCorp Vault is released under the [Mozilla Public License 2.0](https://github.com/hashicorp/vault/blob/main/LICENSE).