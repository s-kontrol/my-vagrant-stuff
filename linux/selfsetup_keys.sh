#!/bin/bash

display_warning() {
  echo "Warning: $1"
}

bridge_interface=$(ip link show type bridge | awk -F: '/^[0-9]/ {print $2}' | awk '{print $1}' | head -n 1)
if [ -z "$bridge_interface" ]; then
  display_warning "No bridge interface found"
  exit 1
else
  echo "Bridge interface found: $bridge_interface"
fi

if [ ! -d ~/.ssh ]; then
  display_warning "No .ssh directory found. Creating one.."
  mkdir -m 700 ~/.ssh
fi

vagrant_key_path=~/.ssh/vagrant-ansible
if [ ! -f "${vagrant_key_path}.pub" ]; then
  display_warning "No public key found. Creating one.."
  ssh-keygen -t rsa -b 2048 -f "$vagrant_key_path" -N ""
fi

vagrant_key=$(cat "${vagrant_key_path}.pub")
if ! grep -qF "$vagrant_key" ~/.ssh/authorized_keys; then
  display_warning "No authorized_keys file found. Adding our key..."
  cat "${vagrant_key_path}.pub" >> ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
fi
