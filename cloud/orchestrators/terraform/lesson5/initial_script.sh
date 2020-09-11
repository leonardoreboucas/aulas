#/bin/bash
#####################################
#  INSTALL DOCKER ENGINE
#####################################
apt-get update
apt-get install -y git apt-transport-https ca-certificates curl gnupg-agent software-properties-common mysql-client
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

#####################################
#  CONFIGURE DATABASE
#####################################
docker run -t --name mysql57 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_DATABASE=example -d mysql:5.7
git clone https://github.com/leonardoreboucas/lessons.git
cd lessons/cloud/orchestrators/sample-app/
pwd
ls -la
#while [ $(netstat -nlp | grep :3306 | grep docker-proxy | wc -l) -eq 0 ]; do
#  sleep 1;
#done
mysql -h 127.0.0.1 -pmysql example < customer.sql

#####################################
#  CONFIGURE APPLICATION
#####################################
docker build -t app-sample .
docker run -it -p 80:80 -e DB_PASSWORD=mysql -e DB_HOST=172.17.0.2 -e DB_PORT=3306 app-sample
