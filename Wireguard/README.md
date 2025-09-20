# WireGuard VPN Setup

Este pacote contém três scripts (`server.sh`, `empresa.sh`, `casa.sh`) e também os arquivos `.conf` prontos para importar em clientes gráficos do WireGuard.

## 📂 Conteúdo
- `server.sh` → configura a VPS como servidor WireGuard
- `empresa.sh` → configura o PC da empresa como cliente
- `casa.sh` → configura o PC de casa como cliente
- `server.conf` → configuração pura para importar em cliente gráfico (somente servidor)
- `empresa.conf` → configuração pura para importar em cliente gráfico (PC da empresa)
- `casa.conf` → configuração pura para importar em cliente gráfico (PC de casa)

## 🚀 Instruções de uso dos scripts
1. Copie o script correspondente para a máquina correta (`/tmp` por exemplo).
2. Edite `empresa.sh` e `casa.sh` para substituir `<IP_DA_VPS>` pelo **IP público real** da VPS.
3. Dê permissão de execução:
   ```bash
   chmod +x server.sh empresa.sh casa.sh
   ```
4. Execute o script com `sudo`:
   ```bash
   sudo ./server.sh
   sudo ./empresa.sh
   sudo ./casa.sh
   ```

## 🎛️ Uso com cliente gráfico
Se preferir usar o **cliente gráfico do WireGuard** (Windows, macOS, Linux ou Mobile):
- Importe diretamente o arquivo `.conf` correspondente (`empresa.conf` ou `casa.conf`).
- No arquivo `.conf`, substitua `<IP_DA_VPS>` pelo IP público real da VPS.

## 🔍 Testes
Após subir as interfaces:
- Teste o ping da máquina de casa → empresa:
  ```bash
  ping 10.0.0.2
  ```
- Acesse via SSH:
  ```bash
  ssh osboxes@10.0.0.2
  ```

---

Boa conexão via VPN 🚀
