#!/bin/bash

# Copyright 2023 cao
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Setup desired software on System
# Assuming Fedora 37

# Upgrade to newest Kernel, etc.
sudo dnf upgrade

# Address the damn NVidia shit
sudo dnf install akmod-nvidia

# Add Required Repos
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo


# Unfilter Flathub
sudo flatpak remote-delete flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Entertainment
sudo dnf install lutris
wget https://github.com/doitsujin/dxvk/releases/download/v1.3.1/dxvk-1.3.1.tar.gz 
tar -xf dxvk-1.3.1.tar.gz -C /home/cao/.local/share/lutris/runtime/dxvk/
mv /home/cao/.local/share/lutris/runtime/dxvk/dxvk-v1.3.1 /home/cao/.local/share/lutris/runtime/dxvk/v1.3.1


# Virtual machinery 
sudo dnf install virt-manager 
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Develry
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh
