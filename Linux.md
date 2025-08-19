# DebianFreshInstall
Tools that i use in daily common
Lampp Setup
https://raw.githubusercontent.com/felipesms2/LampSetup/main/README.md

<br>

#Util tools

mount tmp folder im ram instead
  mkdir /tmp/ramdisk  &&  sudo mount -t tmpfs -o size=1400m myramdisk /tmp/ramdisk
  
# #Allow AnyDesk

sudo wget https://raw.githubusercontent.com/felipesms2/DebianFreshInstall/main/AnyDeskAllow.sh -P /tmp && sudo mv /tmp/AnyDeskAllow.sh /etc/gdm3/custom.conf

<br>

<b><i> lsbk </b></i> List storage devices <br>
<b><i> dd if=file.iso of=/dev/of/destination </b></i> Clone disk to another <br>
<b><i> ps aux | grep firefox </b></i> Search PID <br>
<b><i> kill -9 40600 </b></i> Kill by pid <br>
<b><i> sudo ss -lptn 'sport = :80' # check process from port  <br>
<b><i> sudo lsof -nP -iTCP -sTCP:LISTEN # check process from port (more on https://phoenixnap.com/kb/linux-check-open-ports)  <br>
<br><i>sudo update-alternatives --config x-session-manager # default desktop on rdp https://forum.xfce.org/viewtopic.php?id=14108<i></b>
<br><i>apt install tmux nmap iproute2 nano vim timeshift virtualbox-qt<i></b>


# Disable dynamic ipv6

cat >> /etc/sysctl.conf <<EOT
net.ipv6.conf.all.use_tempaddr=0
net.ipv6.conf.default.use_tempaddr=0
EOT

sysctl -p

https://askubuntu.com/questions/1392414/how-to-disable-temporary-dynamic-ipv6-addresses-in-ubuntu-21-10

# Unrar a rar file

7z x yourfile.rar

# 7z archive without compression and split

 7z a -t7z -mx0 -v1900m output.7z yourfile

 a : Add files to the archive.
-t7z : Specifies the archive type (7z format).
-mx0 : Sets the compression level to 0 (no compression).
-v1900m : Splits the archive into volumes of 1900 MB each.

# Link a executable to system path

```bash
sudo ln -s /home/d/applications/Postman/Postman /usr/local/bin/postman
```

# Add application to Launcher

  ## 1. Create a Symbolic Link for Terminal Access

  ```bash
  sudo nano /usr/share/applications/postman.desktop
  ```
  ## 2. Add Postman to GNOME Launcher (Application Menu)

  ```bash
  echo -e "[Desktop Entry]\nName=Postman\nComment=API Development Environment\nExec=/home/d/applications/Postman/Postman\nIcon=/home/d/applications/Postman/app/resources/app/assets/icon.png\nTerminal=false\nType=Application\nCategories=Development;" > /usr/share/applications/postman.desktop
  chmod +x /usr/share/applications/postman.desktop
  sudo update-desktop-database
  # [Desktop Entry]
  # Name=Postman
  # Comment=API Development Environment
  # Exec=/home/d/applications/Postman/Postman
  # Icon=/home/d/applications/Postman/app/resources/app/assets/icon.png
  # Terminal=false
  # Type=Application
  # Categories=Development;
  ```

  # Zip a file with YYYYMMDD_HHMMSS.zip

  ```bash
  zip -r "jornal3_backup_$(date +%Y-%m-%d_%H_%M_%S).zip" jornal3
  ```

  # Set zsh as default shell

  ```bash
  chsh -s $(which zsh)
  ```

  # Install zsh and oh-my-zsh

  ```bash
  sudo apt install zsh -y
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```