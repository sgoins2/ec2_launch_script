#!/bin/bash
yum update -y   #update system packages
yum install -y httpd    #install apache server
systemctl start httpd   #start apache service
systemctl enable httpd  #allow apache to start on system boot
echo "<h1>Welcome to the Homepage</h1>" > /var/www/html/index.html     #output of index.html header 