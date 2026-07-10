#!/bin/bash
# Update system packages and install Apache
dnf update -y
dnf install -y httpd

# Gather system details
HOSTNAME=$(hostname)
IP_ADDR=$(hostname -I | awk '{print $1}')
OS_INFO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)

# Create custom landing page in the RHEL web directory
cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>RHEL Web Server Info</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f9; color: #333;">
    <h1>Azure RHEL Web Server</h1>
    <p><strong>Hostname:</strong> $HOSTNAME</p>
    <p><strong>Internal IP:</strong> $IP_ADDR</p>
    <p><strong>Operating System:</strong> $OS_INFO</p>
    <p><strong>Deployment Time:</strong> $(date)</p>
</body>
</html>
HTML

# Configure firewall to allow HTTP traffic locally if needed
firewall-cmd --permanent --add-service=http
firewall-cmd --reload

# Start and enable the Apache service
systemctl enable httpd
systemctl start httpd
