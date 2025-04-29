# LampSetup
For Docker and Virtual Machines even local runtime enviroment that need php backend

  apt update && apt upgrade -y && apt install openssh iproute2 tor -y && sshd <br>      

  sudo su <br>
  apt update <br>
  apt upgrade -y <br>
  apt install \ <br>
  sudo sqlite3 wget curl \ <br>
  sqlite3 \ <br>
  apache2 \ <br>
  php \ <br>
  php-mongodb \ <br>
  phpunit \ <br>
  php-gd \ <br>
  php-sqlite3 \ <br>
  php-bcmath \ <br>
  php-redis \ <br>
  php-gmp \ <br>
  php-interbase \ <br>
  php-odbc \ <br>
  php-mysql \ <br>
  php-curl \ <br>
  php-xml \ <br>
  php-intl \ <br>
  php-mbstring \ <br>
  mariadb-server \ <br>
  ssh \ <br>
  composer \ <br>
  git \ <br>
  nodejs \ <br>
  npm \ <br>
  nano \ <br>
  php-zip \ <br>
  php-pear \ <br>
  php-dev \ <br>
  nmap \ <br>
  neofetch \ <br>

  python3-pip \ <br> 
  python3-tk \ <br>
  python3-dev \ <br>
  net-tools \ <br>
  iproute2 -y  ; <br> \
 a2enmod rewrite ; <br> \
 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash ; <br> \
 systemctl restart apache2 <br>
 
 chown -R $USER:$USER /var/www/html/
nano /etc/apache2/ports.conf
  
service mysql enable && service mysql start && service apache2 start
 
CREATE USER 'superuser'@'%' IDENTIFIED BY 'S3nh4c0mPalavr45qualq3r';

GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');

# Docker Templates

 
 
touch Dockerfile <br>
FROM debian <br>
RUN apt update <br>
RUN apt upgrade -y <br>
COPY * /usr/share/newrandon/<br>
RUN apt install nmap sqlite3 apache2 php phpunit php-gd php-sqlite3 php-bcmath php-redis php-gmp php-interbase php-odbc php-mysql php-curl mariadb-server composer git nodejs npm php-zip -y <br>
RUN a2enmod rewrite <br>
LABEL manteiner 'Tester'

# Composer 

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'c31c1e292ad7be5f49291169c0ac8f683499edddcfd4e42232982d0fd193004208a58ff6f353fde0012d35fdd72bc394') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# Php my admin

wget https://github.com/felipesms2/LampSetup/raw/master/applications/pma.zip

# Allow MariaDb External Connect

Article https://webdock.io/en/docs/how-guides/database-guides/how-enable-remote-access-your-mariadbmysql-database

sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf

bind to 0.0.0.0

# full permission www user

sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';" && sudo mysql -u root -e "FLUSH PRIVILEGES;"


