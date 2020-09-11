#/bin/bash
apt-get update
apt-get install -y git nodejs mysql-server
git clone https://github.com/leonardoreboucas/lessons.git
cd lessons/cloud/orchestrators/sample-app/
npm install --no-optional
npm start
