#!/bin/bash

##############################################################################################################
# This is not something you'd actually execute on the nodes, more like a note to self on what steps were taken
# Possible improvements: turn node preparation and RKE2 installation into an Ansible playbook
##############################################################################################################

# Allow nopasswd sudoing
echo "%sudo ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/nopasswd

# Update OS
sudo apt-get update && sudo apt-get upgrade -y

# Create config file
sudo mkdir -p /etc/rancher/rke2/
sudo nano /etc/rancher/rke2/config.yaml

### Install RKE2 as usual, see the node config yaml templates for the config file

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Access kubeconfig
# (Then again, normally you'd want to grab the kubeconfig from the RKE2 server, instead of doing this)
echo "alias k='sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml'" >> ~/.bash_aliases
echo "alias h='sudo helm --kubeconfig /etc/rancher/rke2/rke2.yaml'" >> ~/.bash_aliases
. ~/.bash_aliases