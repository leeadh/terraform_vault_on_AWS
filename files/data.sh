#!/bin/bash
sleep 10
echo "Unsealing...."
export VAULT_ADDR="http://127.0.0.1:8200"
vault operator init -key-shares=1 -key-threshold=1 > /tmp/key.txt
vault operator unseal $(grep 'Key 1:' /tmp/key.txt | awk '{print $NF}') > /tmp/operator.txt
vault login $(grep 'Initial Root Token:' /tmp/key.txt | awk '{print $NF}') > /tmp/token.txt