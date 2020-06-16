


sudo ifconfig $1 down
sudo ifconfig $1 10.10.10.100 netmask 255.255.255.0 up
sudo rarpd $1
ping 10.10.10.16
