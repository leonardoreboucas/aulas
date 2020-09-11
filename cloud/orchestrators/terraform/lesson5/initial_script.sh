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
docker run --name mysql57 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_DATABASE=example -d mysql:5.7
git clone https://github.com/leonardoreboucas/lessons.git
cd lessons/cloud/orchestrators/sample-app/
mysql -h 127.0.0.1 -pmysql example < customer.sql

#####################################
#  CONFIGURE APPLICATION
#####################################
#docker run --name app -p 80:80 -e DB_HOST=mysql57 -e DB_USERNAME=root -e DB_PASSWORD=mysql -e DB_PORT=3306 -d node:12.18


#apt-get install -y git nodejs mysql-server
#git clone https://github.com/leonardoreboucas/lessons.git
#cd lessons/cloud/orchestrators/sample-app/
#npm install --no-optional
#npm start
