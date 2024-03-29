domain="tsi.mil"
localCertDir="../certificates"

HOST_IP=$(ip addr show ens192 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

#GITLAB
gitlabFQDN="localhost"
gitlabConfigVolume="../GitLab/volumes/config"
gitlabCertPath="$gitlabConfigVolume/ssl"

#RUNNER
runnerConfigVolume="../Runner/volumes/config"
runnerCertPath="$runnerConfigVolume/certs"

#REGISTRY
registryFQDN="tsi.mil"
registryConfigVolume="../Registry/volumes/config"
registryCertPath="$registryConfigVolume/ssl"

#VAULT
vaultFQDN="vault14.tsi.mil"
vaultConfigVolume="../Vault/volumes/config"
vaultCertPath="$vaultConfigVolume/ssl"

# Make the cert directories (recursively)
for directory in $runnerCertPath $gitlabCertPath $vaultCertPath
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
cp $localCertDir/$domain.crt $runnerCertPath/ca.crt
cp $localCertDir/\*.$domain.crt $runnerCertPath

# #Restart the runner
# docker compose -f Runner/docker-compose.yml down
# docker compose -f Runner/docker-compose.yml up -d

# docker compose down

# docker compose up -d

# openssl s_client -connect gitlab.tsi.mil:8443 -servername gitlab.tsi.mil -showcerts

# docker logs gitlab-gitlab