#!/usr/bin/env bash
# 
#author: wangxin
#date： 
#usage: 


ip_online() {
  for i in $(seq 2 254);do
   { 
    ping -c3 $1.${i} 
    if [ $? -eq 0 ];then
      echo $1.${i} >> /opt/online_ip.txt
    fi      
   }&
done
wait
}

if [ ! -f /opt/online_ip.txt ];then
  ip_online 10.9.32
fi

if [ ! -f $HOME/.ssh/id_rsa ];then
  ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa
fi

for ip in $(cat /opt/online_ip.txt);do
  {
  expect <<-EOF
    spawn ssh-copy-id root@${ip}
    expect "yes/on" { send "yes\r"}
    expect "password" { send "1\r"}
    expect eof
EOF
  }&
done
wait
 
  
