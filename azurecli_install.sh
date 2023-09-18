#!/bin/bash

# need to force specific version due to debian/wsl2 issues on latests
#
# to list available versions use: apt-cache policy azure-cli
#

azcli_version="2.44.1-1"
distro=$(lsb_release -cs)

sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

# check if repo already added
if $(! find /etc/apt/ -name *.list | xargs cat | grep  ^[[:space:]]*deb | grep -q azure-cli); then
  echo "add azure-cli repo"
  sudo mkdir -p /etc/apt/keyrings
  curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
  sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
  echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $distro main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
  sudo apt-get update
fi

# if azure-cli installed - clean it
if dpkg-query -W --showformat='${Status}\n' azure-cli | grep -q "installed"; then
  sudo apt-get remove -y --allow-change-held-packages azure-cli
fi

# install azure-cli
sudo apt-get install azure-cli=$azcli_version~$distro

# show working azure-cli
az --version

# set autoinstall extensions with prompt
az config set extension.use_dynamic_install=yes_prompt

