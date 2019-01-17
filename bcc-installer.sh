#!/bin/bash

HS=$(uname -r)
apt-get update
#First install bcc from debian repository then install the other tools from iovisor repository
apt-get install bcc sudo curl linux-headers-$HS --force-yes --yes
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4052245BD4284CDD
echo "deb [trusted=yes] https://repo.iovisor.org/apt/xenial xenial-nightly main" | sudo tee /etc/apt/sources.list.d/iovisor.list
apt-get update
apt-get install bcc-tools libbcc-examples
HJ=$(echo $(echo $(uname -r) | cut -d'-' -f1-2))
BPFTRACE_KERNEL_HEADERS=/lib/modules/$(uname -r):/usr/src/linux-headers-$(uname -r):/usr/src/linux-headers-$HJ-common
BCC_KERNEL_SOURCE=$BPFTRACE_KERNEL_HEADERS
echo "export BPFTRACE_KERNEL_HEADERS=$BPFTRACE_KERNEL_HEADERS" >> /etc/bash.bashrc
echo "export BCC_KERNEL_SOURCE=$BPFTRACE_KERNEL_HEADERS" >> /etc/bash.bashrc
ln -s /usr/src/linux-headers-${HS}/include/config/ /lib/modules/${HS}/source/include/config
ln -s /usr/src/linux-headers-${HS}/include/generated/ /lib/modules/${HS}/source/include/generated
