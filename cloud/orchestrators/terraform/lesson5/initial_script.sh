#/bin/bash
#####################################
#  INSTALL DOCKER ENGINE
#####################################
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

#apt-get install -y git nodejs mysql-server
#git clone https://github.com/leonardoreboucas/lessons.git
#cd lessons/cloud/orchestrators/sample-app/
#npm install --no-optional
#npm start
