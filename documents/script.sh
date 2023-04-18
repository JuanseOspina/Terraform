#!/bin/bash

ips=($(cat documents/test_ip.txt))
texto=$(cat documents/format.yaml)
texto_modificado=$(echo "$texto" | sed "s/ip_1/${ips[0]}/g;s/ip_2/${ips[1]}/g;s/ip_3/${ips[2]}/g")
echo "$texto_modificado" > inventory.yaml