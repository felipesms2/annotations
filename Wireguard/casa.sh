#!/bin/bash
set -e

VPS_IP="<IP_DA_VPS>"
WG_CONF="/etc/wireguard/wg0.conf"

echo "[*] Parando qualquer WireGuard ativo..."
sudo wg-quick down wg0 2>/dev/null || true
sudo systemctl stop wg-quick@wg0 2>/dev/null || true
sudo ip link delete wg0 2>/dev/null || true

echo "[*] Limpando configs antigas..."
sudo rm -f $WG_CONF

echo "[*] Criando wg0.conf (casa)..."
sudo tee $WG_CONF > /dev/null <<EOF
[Interface]
Address = 10.0.0.3/24
PrivateKey = cAoeVfEbRxDKzA0bsrwP2zgZrt3APmzDtdQ/jkEgXVc=

[Peer]
PublicKey = mbEa7PwoSJmctnsZ8wL9Q8P9EeUNF0rsMvilBjDMmWg=
Endpoint = $VPS_IP:51820
AllowedIPs = 10.0.0.0/24
PersistentKeepalive = 25
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
