# Make the updated .env files in each of the services folders

HOST_IP=$(ip addr show ens192 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

# Read host input to get the password
echo "Enter the default password for the services"
read DEFAULT_PASSWORD
#If there is a $ in the password, add another $ to escape it
DEFAULT_PASSWORD=$(echo $DEFAULT_PASSWORD | sed 's/\$/\$\$/g')

for service in "Runner" "Runner-Helper" "Vault" "KeyCloak" "GitLab"
do
    echo "Making .env file for $service"
    echo "HOST_IP=$HOST_IP" > ../$service/.env
    echo "DEFAULT_PASSWORD=$DEFAULT_PASSWORD" >> ../$service/.env
done