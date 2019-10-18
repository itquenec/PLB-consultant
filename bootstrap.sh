#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 dmaster.plb.form docker-master
172.42.42.101 dworker1.plb.form docker-worker1
172.42.42.102 dworker2.plb.form docker-worker2
EOF

#install epel-release & other things
yum install -y -q epel-release
yum install vim

#install ansible
yum --enablerepo=epel install ansible

#install ntp && configure timedate
yum install -y ntp
timedatectl set-timezone Europe/Paris
systemctl start ntpd
systemctl enable ntpd
ntpd -q

# Disable SELinux
echo "[TASK 4] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Stop and disable firewalld
echo "[TASK 5] Stop and Disable firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 12] Set root password"
echo "ansible" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
