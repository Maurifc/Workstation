#!/bin/bash
sudo su
apt update && \
    apt install nfs-kernel-server -y

mkdir /nfs_share
chmod 777 /nfs_share

echo "/nfs_share  192.168.0.0/16 (rw,sync,no_subtree_check)" >> /etc/exports

exportfs -a &> /dev/null
systemctl restart nfs-kernel-server
