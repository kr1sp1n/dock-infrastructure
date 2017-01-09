#!/bin/bash

sudo apt-get update
sudo apt-get --yes install apt-transport-https ca-certificates

# dev dependencies
sudo apt-get --yes install git

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get --yes install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get --yes install docker-engine
sudo service docker start

mkdir -p ~/Code

# my dotfiles and mount ~/Code to /data
docker create -v /root --name dotfiles kr1sp1n/dotfiles
docker create -v ~/Code:/data --name data tianon/true

# run dock
docker run --privileged --name dock --rm -it -v ~/.ssh:/root/.ssh -v /var/run/docker.sock:/var/run/docker.sock --volumes-from data --volumes-from dotfiles kr1sp1n/dock
