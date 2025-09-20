
```bash
# 1. Clonar o repositório oficial
git clone https://github.com/iv-org/invidious.git
cd invidious

# 2. Gerar chaves secretas (HMAC e Companion)
HMAC_KEY=$(openssl rand -hex 32)
COMPANION_KEY=$(openssl rand -hex 32)

echo "HMAC_KEY: $HMAC_KEY"
echo "COMPANION_KEY: $COMPANION_KEY"

# 3. Criar arquivo docker-compose.override.yml com suas configs locais
cat > docker-compose.override.yml <<EOF
version: "3.8"

services:
  invidious:
    ports:
      - "127.0.0.1:3000:3000"  # acessível só local
    environment:
      INVIDIOUS_CONFIG: |
        db:
          dbname: invidious
          user: kemal
          password: kemal
          host: invidious-db
          port: 5432
        check_tables: true
        hmac_key: "$HMAC_KEY"
        invidious_companion_key: "$COMPANION_KEY"
EOF

# 4. Subir os containers
docker compose up 

# 5. Acompanhar logs (opcional)
<!-- docker-compose logs -f invidious -->```
