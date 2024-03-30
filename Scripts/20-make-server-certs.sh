domain=$(awk -F "=" '/^DOMAIN/ {print $2}' .domain)

localCertDir="../certificates"

mkdir -p $localCertDir

ipAddress=$(ip addr show ens192 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

# Create the server certificates
for server in "*"
do

    fqdn="$server.$domain"

    # Generate the private key in PKCS#8 format
    openssl genpkey -algorithm RSA -out $localCertDir/$fqdn.key

    # Create the CSR
    openssl req -new -sha256 -nodes -key $localCertDir/$fqdn.key -subj "/C=US/ST=WA/L=EN/O=Infrastructure/CN=$fqdn" -out $localCertDir/$fqdn.csr

    echo "[ san ]" > $localCertDir/san.conf
    echo "subjectAltName=DNS:$fqdn,IP:$ipAddress" >> $localCertDir/san.conf

    # Generate the cert from the CSR and sign it with the CA's root key
    openssl x509 -req -extfile  $localCertDir/san.conf -in $localCertDir/$fqdn.csr -CA $localCertDir/$domain.crt -CAkey $localCertDir/$domain.key -CAcreateserial -out $localCertDir/$fqdn.crt -days 3649 -sha256 -extensions san

    # Remove the san.conf
    rm $localCertDir/san.conf

    # Verify the cert
    openssl x509 -in $localCertDir/$fqdn.crt -text -noout

    # Add the CA to the Cert
    cat $localCertDir/$domain.crt >> $localCertDir/$fqdn.crt
done
