localCertDir="../certificates"

# Read host input to get the password
echo "Enter the Base Domain for all services"
read domain
echo "DOMAIN=$domain" > ./.domain

mkdir -p $localCertDir
rm -f $localCertDir/*

# Create the root key (RSA)
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out $localCertDir/$domain.key

# Create a root cert and self-sign it
openssl req -new -nodes -key $localCertDir/$domain.key -subj "/C=US/ST=WA/L=EN/O=Infrastructure/CN=$domain" -out $localCertDir/$domain.csr

# Generate the root cert
openssl x509 -req -days 3650 -in $localCertDir/$domain.csr -signkey $localCertDir/$domain.key -out $localCertDir/$domain.crt

# Copy the certificate to the ca-certificates directory and update the ca-certificates
cp $localCertDir/$domain.crt /usr/local/share/ca-certificates/$domain.crt
update-ca-certificates

# Change ownership of the certificates to toor
chown -R toor:toor $localCertDir