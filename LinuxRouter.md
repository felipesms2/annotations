# README SAGRADO

## O dia em que o Linux Mint virou um roteador VPN WireGuard funcional

Data: 19 de Maio de 2026
Máquina: Dell Latitude E7470
Sistema: Linux Mint
VPN: Surfshark WireGuard
Objetivo: Receber internet pela Ethernet e redistribuir via Wi‑Fi SOMENTE pela VPN.

---

# Resultado Final

Arquitetura operacional:

```text
Internet
   ↓
Ethernet (enp0s31f6)
   ↓
Linux Mint
   ↓
WireGuard (wg0)
   ↓
Hotspot Wi‑Fi (wlp1s0)
   ↓
Clientes conectados
```

Tudo funcionando:

* WireGuard ativo
* Surfshark operacional
* Hotspot Wi‑Fi ativo
* NAT funcionando
* Kill switch funcionando
* IP forwarding funcionando
* Boot automático funcionando
* Sem vazamento pela Ethernet
* DNS pela VPN

IP validado:

```bash
curl ipv4.icanhazip.com
```

Resultado:

```text
138.199.58.40
```

VPN confirmada.

---

# Interfaces da máquina

```text
enp0s31f6 = Ethernet
wlp1s0    = Wi‑Fi
wg0       = WireGuard
```

---

# Instalação dos pacotes

```bash
sudo apt update
sudo apt install wireguard wireguard-tools resolvconf iptables-persistent
```

---

# Geração de chaves

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

Arquivos:

```text
/etc/wireguard/privatekey
/etc/wireguard/publickey
```

Permissões:

```bash
chmod 600 privatekey
chmod 600 wg0.conf
```

---

# Configuração do WireGuard

Arquivo:

```text
/etc/wireguard/wg0.conf
```

Conteúdo:

```ini
[Interface]
Address = 10.14.0.2/16
PrivateKey = SUA_PRIVATE_KEY
DNS = 162.252.172.57, 149.154.159.92

[Peer]
PublicKey = IFTVXxhLEqVgZI/JGOPRtmrNUQW1DNljeBe8Ys7v90A=
AllowedIPs = 0.0.0.0/0
Endpoint = br-sao.prod.surfshark.com:51820
PersistentKeepalive = 25
```

---

# Ativar WireGuard

```bash
sudo wg-quick up wg0
```

Verificar:

```bash
wg
```

Handshake esperado:

```text
latest handshake
transfer
```

---

# Hotspot Wi‑Fi

Criação do hotspot:

```bash
nmcli device wifi hotspot \
    ifname wlp1s0 \
    ssid SurfVPN \
    password "senha12345"
```

---

# Ativar IP forwarding

Runtime:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

Persistente:

```bash
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p
```

Validar:

```bash
sysctl net.ipv4.ip_forward
```

Resultado esperado:

```text
net.ipv4.ip_forward = 1
```

---

# NAT pelo WireGuard

```bash
sudo iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

sudo iptables -A FORWARD -i wlp1s0 -o wg0 -j ACCEPT

sudo iptables -A FORWARD -i wg0 -o wlp1s0 \
    -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

---

# Kill Switch

Bloquear saída direta pela Ethernet:

```bash
sudo iptables -A FORWARD -i wlp1s0 -o enp0s31f6 -j DROP
```

Resultado:

* Se a VPN cair → internet cai
* Sem leak pela Ethernet

---

# Persistir firewall

```bash
sudo netfilter-persistent save
sudo systemctl enable netfilter-persistent
```

---

# Boot automático

WireGuard:

```bash
sudo systemctl enable wg-quick@wg0
```

Hotspot:

```bash
sudo nmcli connection modify Hotspot connection.autoconnect yes
```

---

# Comandos de diagnóstico

Interfaces:

```bash
ip link
```

Status WireGuard:

```bash
wg
```

IP externo:

```bash
curl ipv4.icanhazip.com
```

Rotas:

```bash
ip route
```

iptables:

```bash
sudo iptables -L -n -v
sudo iptables -t nat -L -n -v
```

---

# Testes finais

## DNS leak

[https://www.dnsleaktest.com/](https://www.dnsleaktest.com/)

## Ver IP

[https://whatismyipaddress.com/](https://whatismyipaddress.com/)

## Teste de kill switch

Desligar VPN:

```bash
sudo wg-quick down wg0
```

Resultado esperado:

* Clientes Wi‑Fi ficam sem internet
* Nenhum tráfego sai pela Ethernet

Religar:

```bash
sudo wg-quick up wg0
```

---

# Conclusão

Depois de inúmeras tentativas, erros de rota, DNS quebrado, NetworkManager brigando, interfaces inconsistentes, NAT falhando, WireGuard subindo sem tráfego, e incontáveis sessões de debug:

FUNCIONOU.

O Linux Mint virou um roteador VPN WireGuard funcional.

Este foi o primeiro setup completamente operacional:

* VPN real
* Hotspot funcional
* Kill switch ativo
* Persistente no boot
* Sem vazamento
* Produção utilizável

Marco técnico registrado.

---

# Próximos upgrades futuros

Possíveis melhorias:

* hostapd
* dnsmasq
* nftables puro
* IPv6 leak prevention
* watchdog automático do túnel
* QoS
* dual-band tuning
* isolamento de clientes
* captive portal bypass
* dashboard web
* travel-router mode

Mas este README documenta o primeiro estado funcional completo.

E isso importa.
