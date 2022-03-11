#!/bin/bash
export ADDR=49ERscAZekwbCDZ3MqV2rhEwTqx1UbihGFCeSRK7Vsy8f6EA5xH151JRmvhAoV2sta2U9eV6CgeNt7u6jTfQ4WtYGbGQygd
sudo apt-get update
sudo apt-get install -y curl
curl https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-focal-x64.tar.gz -O
# 49ERscAZekwbCDZ3MqV2rhEwTqx1UbihGFCeSRK7Vsy8f6EA5xH151JRmvhAoV2sta2U9eV6CgeNt7u6jTfQ4WtYGbGQygd
# unpack
tar -xvzf xmrig-6.16.4-focal-x64.tar.gz
./xmrig -o pool.minexmr.com:4444 -u $ADDR