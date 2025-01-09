# Only one single output remains unspent from block 123,321. What address was it sent to?

block_height=123321
blockhash=$(bitcoin-cli getblockhash "$block_height")
block=$(bitcoin-cli getblock "$blockhash" true)

txids=$(echo "$block" | jq -r '.tx[]')
for txid in $txids; do
  tx=$(bitcoin-cli getrawtransaction "$txid" true)
  echo "$tx" | jq -c '.vout[]' | while read -r vout; do
    n=$(echo "$vout" | jq -r '.n')
    unspent=$(bitcoin-cli gettxout "$txid" "$n")
    if [ -n "$unspent" ]; then
      address=$(echo "$vout" | jq -r '.scriptPubKey.address')
      echo "$address"
      exit 0
    fi
  done
done
