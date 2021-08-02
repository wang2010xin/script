#!/usr/bin/env bash
#
#usage : 网卡动态改静态
#date : 2021.07.09
#author : wangxin

function modify_network_interface() {
  local network_config_file_path="/etc/sysconfig/network-scripts/ifcfg-ens33"

  sed -i '/^BOOTPROTO/cBOOTPROTO="none"' ${network_config_file_path}
  sed -i '/^ONBOOT/cONBOOT="yes"' ${network_config_file_path}

  local arrayA=($(ifconfig | grep "inet" | head -1))
  local local_ipaddr=${arrayA[1]}

  echo "IPADDR=" >> ${network_config_file_path}
  sed -i "s/IPADDR=/IPADDR=${local_ipaddr}/" ${network_config_file_path}

  echo "GATEWAY=" >> ${network_config_file_path}
  sed -i "s/GATEWAY=/GATEWAY=$(echo ${arrayA[-1]} | sed -n 's/255/1/p')/" ${network_config_file_path}

  sed -i '$aNETMASK=255.255.255.0' ${network_config_file_path}
  sed -i '$aDNS1=8.8.8.8' ${network_config_file_path}
  }
			  
  modify_network_interface
