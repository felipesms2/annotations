#!/usr/bin/env bash

set -e

POSTMAN_URL="https://dl.pstmn.io/download/latest/linux64"
INSTALL_DIR="/opt/postman"
DESKTOP_FILE="/usr/share/applications/postman.desktop"
TMP_ARCHIVE="/tmp/postman.tar.gz"

echo "▶ Downloading Postman..."
wget -q --show-progress "$POSTMAN_URL" -O "$TMP_ARCHIVE"

echo "▶ Removing old installation (if any)..."
sudo rm -rf "$INSTALL_DIR"

echo "▶ Extracting Postman..."
sudo tar -xzf "$TMP_ARCHIVE" -C /opt
sudo mv /opt/Postman "$INSTALL_DIR"

echo "▶ Creating symlink..."
sudo ln -sf "$INSTALL_DIR/Postman" /usr/bin/postman

ICON_PATH="$INSTALL_DIR/app/resources/app/assets/icon.png"

echo "▶ Creating GNOME launcher..."
sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Postman
Comment=API Development Environment
Exec=/usr/bin/postman
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;
Keywords=api;http;rest;postman;
EOF

echo "▶ Updating desktop database..."
sudo update-desktop-database

echo "▶ Cleaning up..."
rm -f "$TMP_ARCHIVE"

echo "✅ Postman installed successfully!"
echo "➡ Press Super and type 'Postman'"
