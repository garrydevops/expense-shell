#!/bin/bash

yum update -y
dnf install nginx -y 
systemctl enable nginx 
systemctl start nginx 
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload

rm -rf /usr/share/nginx/html/* 

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip