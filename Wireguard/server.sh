#!/bin/bash
set -e

WG_CONF="/etc/wireguard/wg0.conf"

echo "[*] Parando qualquer WireGuard ativo..."
sudo wg-quick down wg0 2>/dev/null || true
sudo systemctl stop wg-quick@wg0 2>/dev/null || true
sudo ip link delete wg0 2>/dev/null || true

echo "[*] Limpando configs antigas..."
sudo rm -f $WG_CONF

echo "[*] Criando wg0.conf (server/VPS)..."
sudo tee $WG_CONF > /dev/null <<EOF
[Interface]
Address = 10.0.0.1/24
PrivateKey = AJ51me66KE/s940bN6hUgkHhFigmy2OkDND9Lvp3JVI=
ListenPort = 51820

[Peer]
PublicKey = 7P+BAZrpG97XSzNz55H0bkXU/leor6VVAQKaDMigrRs=
AllowedIPs = 10.0.0.2/32

[Peer]
PublicKey = YvS6s820LvXWSpyKMyOIWYGu8786Czka3vaKR870wEE=
AllowedIPs = 10.0.0.3/32
EOF

echo "[*] Ajustando permissões..."
sudo chmod 600 $WG_CONF
sudo chown root:root $WG_CONF

echo "[*] Subindo interface WireGuard..."
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

echo "[*] Status da interface wg0:"
sudo wg show
ip a show wg0
