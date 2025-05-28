#!/bin/bash
set -xe

sudo su
su ubuntu
cd /tmp

curl -LsfS https://get.airbyte.com | bash -

# Docker configuration note:
# If you encounter logging issues, you may need to edit /etc/docker/daemon.json:
# echo '{"log-driver": "json-file"}' | sudo tee /etc/docker/daemon.json
# sudo systemctl restart docker.service

abctl local install
