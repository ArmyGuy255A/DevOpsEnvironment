domain="tsi.mil"
localCertDir="../certificates"

HOST_IP=$(ip addr show ens192 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

#GITLAB
gitlabFQDN="localhost"
gitlabConfigVolume="../GitLab/volumes/config"
gitlabCertPath="$gitlabConfigVolume/ssl"

#RUNNER-DIND
runnerDindConfigVolume="../Runner-Dind/volumes/config"
runnerDindCertPath="$runnerDindConfigVolume/certs"

#RUNNER-SHELL
runnerShellConfigVolume="../Runner-Shell/volumes/config"
runnerShellCertPath="$runnerShellConfigVolume/certs"

#REGISTRY
registryFQDN="tsi.mil"
registryConfigVolume="../Registry/volumes/config"
registryCertPath="$registryConfigVolume/ssl"

#VAULT
vaultFQDN="server"
vaultConfigVolume="../Vault/volumes/config"
vaultCertPath="$vaultConfigVolume/ssl"

#KEYCLOAK
keycloakFQDN="server"
keycloakConfigVolume="../KeyCloak/volumes"
keycloakCertPath="$keycloakConfigVolume/truststores"

# Make the cert directories (recursively)
for directory in $runnerDindCertPath $runnerShellCertPath $gitlabCertPath $vaultCertPath $keycloakCertPath
do
    mkdir -p $directory
done

# #rename the old certs for git GitLab Volume
# mv $gitlabCertPath/gitlab.tsi.mil.key $gitlabCertPath/gitlab.tsi.mil.key.old
# mv $gitlabCertPath/gitlab.tsi.mil.crt $gitlabCertPath/gitlab.tsi.mil.crt.old

#copy the new certs to the GitLab Server
cp $localCertDir/*.$domain.crt $gitlabCertPath/$gitlabFQDN.crt
cp $localCertDir/*.$domain.key $gitlabCertPath/$gitlabFQDN.key
cp $localCertDir/*.$domain.crt $gitlabCertPath/$HOST_IP.crt
cp $localCertDir/*.$domain.key $gitlabCertPath/$HOST_IP.key

# #Restart the server
# docker compose -f Server/docker-compose.yml down
# docker compose -f Server/docker-compose.yml up -d

#copy the tsi.mil.crt to ca.crt on the runner
cp $localCertDir/$domain.crt $runnerDindCertPath/ca.crt
cp $localCertDir/*.$domain.crt $runnerDindCertPath

cp $localCertDir/$domain.crt $runnerShellCertPath/ca.crt
cp $localCertDir/*.$domain.crt $runnerShellCertPath

# Copy certs for Vault
cp $localCertDir/$domain.crt $vaultCertPath/ca.crt
cp $localCertDir/*.$domain.crt $vaultCertPath/server.crt
cp $localCertDir/*.$domain.key $vaultCertPath/server.key

# Copy certs for KeyCloak
cp $localCertDir/$domain.crt $keycloakCertPath/ca.crt
cp $localCertDir/*.$domain.crt $keycloakCertPath/server.crt
cp $localCertDir/*.$domain.key $keycloakCertPath/server.key

# #Restart the runner
# docker compose -f Runner/docker-compose.yml down
# docker compose -f Runner/docker-compose.yml up -d

# docker compose down

# docker compose up -d

# openssl s_client -connect gitlab.tsi.mil:8443 -servername gitlab.tsi.mil -showcerts

# docker logs gitlab-gitlab