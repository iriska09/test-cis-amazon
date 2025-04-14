#!/bin/bash
set -e

echo "Updating system..."
sudo dnf update -y

echo "Installing Ansible..."
sudo dnf install -y ansible-core
sudo dnf install -y aws-cli

echo "Bootstrap complete."
