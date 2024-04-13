# Import the CA certificate into the Java keystore
cert1="./volumes/truststores/aria-encrypt.crt"
cert2="./volumes/truststores/aria-sign.crt"
keystore_file="./volumes/truststores/keystore.jks"
DEFAULT_PASSWORD=$(awk -F "=" '/^DEFAULT_PASSWORD/ {print $2}' .env)
# Remove any double $$ from the default password and replace it with a single $
DEFAULT_PASSWORD=$(echo $DEFAULT_PASSWORD | sed 's/\$\$/\$/g')

for cert in $cert1 $cert2
do
    # Extract the base name of the certificate file for a unique alias
    cert_name=$(basename "$cert")
    alias_name="${cert_name%.*}"

    echo "Adding .crt for $cert with alias $alias_name"
    keytool -import -trustcacerts -file "$cert" -alias "$alias_name" -keystore "$keystore_file" -storepass "$DEFAULT_PASSWORD" -noprompt
    
done


