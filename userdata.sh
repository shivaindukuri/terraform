#! /bin/bash
sudo yum install httpd -y
sudo systemctl start  httpd
sudo systemctl status httpd
echo "Hello World" > /var/www/html/index.html