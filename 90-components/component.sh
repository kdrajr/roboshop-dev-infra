#!/bin/bash

component=$1
environment=$2

REPO_URL=https://github.com/kdrajr/ansible-roboshop-roles-tf.git
ANSIBLE_DIR=/opt/roboshop/ansible
REPO_DIR=ansible-roboshop-roles-tf
mkdir -p $ANSIBLE_DIR
mkdir -p /var/log/roboshop
touch /var/log/roboshop/ansible.log

dnf install ansible -y

#### install openssl packages in payment instance before executing ansible playbook to avoid openssl version mismatch error ####
if [ "$component" = "payment" ]; then
   dnf update openssl openssl-libs openssh openssh-server openssh-clients -y 
#    dnf install python3 gcc python3-devel -y
fi
################################################################################################################################

cd $ANSIBLE_DIR

if [ -d $REPO_DIR ]; then
    cd $REPO_DIR
    git pull
else
    git clone $REPO_URL
    cd $REPO_DIR
fi

ansible-playbook -i inventory.ini -e component=$component -e env=$environment main.yaml

#ansible-pull -U https://github.com/kdrajr/ansible-roboshop-roles-tf.git -e component=$component -e env=$environment main.yaml


