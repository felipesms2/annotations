```bash


#!/bin/bash

set -e

DOMAIN="custom-application.test"
TARGET_IP="10.6.2.75"
TARGET_PORT="8089"
NGINX_SSL_DIR="/etc/nginx/ssl"

echo "Atualizando sistema..."
sudo apt update

echo "Instalando Nginx..."
sudo apt install -y nginx

echo "Instalando mkcert..."
sudo apt install -y libnss3-tools curl
if ! command -v mkcert &> /dev/null
then
    curl -L https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v1.4.4-linux-amd64 -o mkcert
    chmod +x mkcert
    sudo mv mkcert /usr/local/bin/
fi

echo "Instalando CA local..."
mkcert -install

echo "Criando diretório SSL..."
sudo mkdir -p $NGINX_SSL_DIR

echo "Gerando certificado para $DOMAIN..."
mkcert $DOMAIN

sudo mv $DOMAIN.pem $NGINX_SSL_DIR/
sudo mv $DOMAIN-key.pem $NGINX_SSL_DIR/

echo "Adicionando domínio ao /etc/hosts..."
if ! grep -q "$DOMAIN" /etc/hosts; then
    echo "127.0.0.1    $DOMAIN" | sudo tee -a /etc/hosts
fi

echo "Criando configuração Nginx..."

sudo tee /etc/nginx/sites-available/$DOMAIN > /dev/null <<EOF
server {
    listen 80;
    server_name $DOMAIN;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $DOMAIN;

    ssl_certificate $NGINX_SSL_DIR/$DOMAIN.pem;
    ssl_certificate_key $NGINX_SSL_DIR/$DOMAIN-key.pem;

    location / {
        proxy_pass http://$TARGET_IP:$TARGET_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}
EOF

echo "Ativando site..."
sudo ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN

echo "Testando configuração..."
sudo nginx -t

echo "Reiniciando Nginx..."
sudo systemctl restart nginx

echo ""
echo "======================================="
echo "Proxy reverso configurado com sucesso!"
echo "Acesse: https://$DOMAIN"
echo "Apontando para: http://$TARGET_IP:$TARGET_PORT"
echo "======================================="



```