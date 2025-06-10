#!/bin/bash

# Variables
VM_IP="34.67.69.28"  # Replace with your GCP VM's external IP
SSH_KEY="~/Desktop/blog/ak_vm_key"  # Path to your SSH private key
REMOTE_DIR="/var/www/html"  # Directory on the VM to host the site

# Build Hugo site
git submodule update --init --recursive
hugo -s anchitkalrablog

# Deploy to GCP VM
rsync -avz -e "ssh -i $SSH_KEY" anchitkalrablog/public/ username@$VM_IP:$REMOTE_DIR