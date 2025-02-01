# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
raw_tx=$(bitcoin-cli getrawtransaction "$txid")
decoded_tx=$(bitcoin-cli decoderawtransaction "$raw_tx")
scriptSig=$(echo "$decoded_tx" | jq -r '.vin[0].scriptSig.hex')
public_key=$(echo "$scriptSig" | grep -oE '[a-fA-F0-9]{66}$')

# out
echo "$public_key"
