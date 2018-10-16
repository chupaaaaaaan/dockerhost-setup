#!/bin/bash

ssh root@192.168.3.9 <<EOF
echo "##########--------- Package update & install ---------##########"
yum -y update
yum -y install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install rsync docker-ce
yum -y clean all

echo
echo "##########--------- Docker settings ---------##########"
mkdir -m 700 -p /etc/docker
cat <<@ > /etc/docker/daemon.json
{
  "storage-driver": "devicemapper"
}
@

systemctl enable docker
systemctl restart docker

EOF

