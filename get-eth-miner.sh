#!/bin/bash
curl -L http://gminer.pro/downloads?res=gminer_2_86_linux64.tar.xz -o gminer_2_86_linux64.tar.xz
tar -xf gminer_2_86_linux64.tar.xz
chmod +x miner
./miner --algo ethash --server eu1.ethermine.org:4444 --user 0xd94eb6c034a3a8802e45092a1b89562777eb0166