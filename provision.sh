#!/bin/bash

sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf

service systemd-resolved restart

sudo apt-get update

# Install python3 for ansible
sudo apt-get -y install python3 python3-pip python3-apt
