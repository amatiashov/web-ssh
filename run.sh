clear
sudo apt update
sudo apt install -y vim ufw

sudo ufw allow OpenSSH
# Disable ICMP
sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules
sudo ufw --force enable


# Install docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce

# Install docker compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.37.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose


curl https://freemyip.com/update?token=${WEB_SSH_DOMAIN_TOKEN}&domain=${WEB_SSH_DOMAIN}

export WEB_SSH_UI_PASSWORD=$(openssl rand -base64 40)

docker compose up -d

# https://stackoverflow.com/a/8467448
echo -e "\n\n"
echo "URL: https://${WEB_SSH_DOMAIN}"
echo "Password: ${WEB_SSH_UI_PASSWORD}"
