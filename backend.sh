#!/bin/bash

#Pre-requisite : add ports in  firewall
sudo -i 
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
#Install nodejs:20 & disable other versions 
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

yum update

#add user 
useradd expense

#copy backend service file
cp backend.service /etc/systemd/system/backend.service
mkdir /app 

#Download the application code to created app directory.
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip 
cd /app 
unzip /tmp/backend.zip

# install dependencies using npm
npm install 

#install mysql 
dnf install mysql -y 
mysql -h <Private IP of SQL> -uroot -pExpenseApp@1 < /app/schema/backend.sql
systemctl daemon-reload
systemctl enable backend 
systemctl start backend 
