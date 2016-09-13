#!/bin/sh

# generate fresh rsa key
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa

# generate fresh dsa key
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

#prepare run dir
mkdir -p /var/run/sshd

# prepare sshd config file for key based auth
sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i "s/#AuthorizedKeysFile/AuthorizedKeysFile/g" /etc/ssh/sshd_config

#prepare ssh config for X forwarding
echo "ForwardX11Trusted yes" >> /etc/ssh/ssh_config
echo "ForwardX11 yes" >> /etc/ssh/ssh_config

#prepare xauth
touch /root/.Xauthority

#generate machine-id
uuidgen > /etc/machine-id


source /etc/profile

exec "$@"
