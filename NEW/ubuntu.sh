#!/bin/bash
# Update system packages
sudo apt-get update -y
sudo apt-get install -y nginx

# Gather system details
HOSTNAME=$(hostname)
IP_ADDR=$(hostname -I | awk '{print $1}')
OS_INFO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)

# Create custom landing page
cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Web Server Info</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f9; color: #333;">
    <h1>Azure Linux Web Server</h1>
    <p><strong>Hostname:</strong> $HOSTNAME</p>
    <p><strong>Internal IP:</strong> $IP_ADDR</p>
    <p><strong>Operating System:</strong> $OS_INFO</p>
    <p><strong>Deployment Time:</strong> $(date)</p>
</body>
</html>
HTML

# Ensure nginx starts automatically
sudo systemctl enable nginx
sudo systemctl start nginx
sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0

