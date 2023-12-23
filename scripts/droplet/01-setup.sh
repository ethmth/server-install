

# Login as root
apt update && apt upgrade -y

# Edit /etc/sudoers to include:
echo "%sudo	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/70-sudo-group

# Create a user
useradd -m e
usermod -aG sudo e
chsh -s /bin/bash e
passwd e
# Then, re-login to user account

# Setup ssh key authentication
mkdir ~/.ssh
touch ~/.ssh/authorized_keys

# Harden SSH
sudo sh -c "echo 'PermitRootLogin no' > /etc/ssh/sshd_config.d/10-disable-root.conf"
sudo systemctl restart sshd


# Setup IPtables rules to block non-SSH, non-HTTP traffic
# sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
# sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# sudo iptables -A INPUT -j DROP
# ^ JUST SET FIREWALL RULES IN VPS CONSOLE INSTEAD

# Install git
sudo apt install git