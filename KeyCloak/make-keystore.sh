#!/bin/bash

# Set the path to the server.crt and server.key files
crt_file="./volumes/truststores/server.crt"
key_file="./volumes/truststores/server.key"
ca_file="./volumes/truststores/ca.crt"
pkcs12_file="keystore.p12"
# Set the path to the keystore.jks file
keystore_file="./volumes/truststores/keystore.jks"

DEFAULT_PASSWORD=$(awk -F "=" '/^DEFAULT_PASSWORD/ {print $2}' .env)
# Remove any double $$ from the default password and replace it with a single $
DEFAULT_PASSWORD=$(echo $DEFAULT_PASSWORD | sed 's/\$\$/\$/g')

rm -f "$keystore_file"

# Step 1: Combine the private key and certificate into a PKCS#12 file
openssl pkcs12 -export -in "$crt_file" -inkey "$key_file" -out "$pkcs12_file" -name keycloak -password pass:"$DEFAULT_PASSWORD"

# Verify creation
if [ $? -ne 0 ]; then
    echo "Failed to create PKCS#12 file. Exiting."
    exit 1
fi

# Step 2: Import the PKCS#12 file into a new Java keystore
keytool -importkeystore -destkeystore "$keystore_file" -deststoretype JKS -deststorepass "$DEFAULT_PASSWORD" -srckeystore "$pkcs12_file" -srcstoretype PKCS12 -srcstorepass "$DEFAULT_PASSWORD" -alias "keycloak"

# Verify import
if [ $? -ne 0 ]; then
    echo "Failed to import into Java keystore. Exiting."
    exit 1
fi

# Import the CA certificate into the Java keystore
keytool -import -trustcacerts -file "$ca_file" -alias "devca" -keystore "$keystore_file" -storepass "$DEFAULT_PASSWORD" -noprompt

if [ $? -ne 0 ]; then
    echo "Failed to import CA certificate into Java keystore. Exiting."
    exit 1
fi

# Cleanup: Remove the temporary PKCS#12 file
rm -f "$pkcs12_file"

echo "Java keystore '$keystore_file' created and loaded successfully."