#!/bin/bash
# 1. Clean cache and install Apache (skipping broken repos if needed)
sudo dnf clean all
sudo dnf install -y httpd --setopt=skip_if_unavailable=True

# 2. Force create the web directory to prevent "No such file or directory" errors
sudo mkdir -p /var/www/html

# 3. Gather system details
HOSTNAME=$(hostname)
IP_ADDR=$(hostname -I | awk '{print $1}')
OS_INFO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)

# 4. Create custom landing page
sudo tee /var/www/html/index.html > /dev/null <<HTML
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

# 5. Fix permissions for the web directory
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# 6. Configure firewall to allow HTTP traffic (ignoring errors if firewalld is not active)
sudo firewall-cmd --permanent --add-service=http 2>/dev/null && sudo firewall-cmd --reload 2>/dev/null

# 7. Start and enable the Apache service
sudo systemctl enable httpd
sudo systemctl start httpd
sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0
