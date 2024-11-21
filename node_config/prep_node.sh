#!/bin/bash

##############################################################################################################
# This is not something you'd actually execute on the nodes, more like a note to self on what steps were taken
# Possible improvements: turn node preparation and RKE2 installation into an Ansible playbook
##############################################################################################################

# Allow nopasswd sudoing
echo "%wheel ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/nopasswd

# SSH setup
mkdir -p ~/.ssh
curl https://github.com/mgelei.keys > ~/.ssh/authorized_keys
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config


# Update OS
sudo dnf update -y && sudo reboot

# We're using an external firewall
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask firewalld

# Create config file
sudo mkdir -p /etc/rancher/rke2/
sudo touch /etc/rancher/rke2/config.yaml
sudo chmod o-r /etc/rancher/rke2/config.yaml
sudo nano /etc/rancher/rke2/config.yaml

### Install RKE2 as usual, see the node config yaml templates for the config file
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service &
journalctl -u rke2-server -f

### Or the agent:
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service
systemctl start rke2-agent.service &
journalctl -u rke2-agent -f

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Access kubeconfig
# (Then again, normally you'd want to grab the kubeconfig from the RKE2 server, instead of doing this)
echo "alias k='sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml'" >> ~/.bashrc
echo "alias h='sudo /usr/local/bin/helm --kubeconfig /etc/rancher/rke2/rke2.yaml'" >> ~/.bashrc
. ~/.bashrc