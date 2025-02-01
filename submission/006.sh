out_h=256128
in_h=257343

out=$(bitcoin-cli getblockhash $out_h)
in=$(bitcoin-cli getblockhash $in_h)

coin=$(bitcoin-cli getblock $out true | jq -r '.tx[0]')

bitcoin-cli getblock $in true | jq -r '.tx[]' | while read txid; do
  vins=$(bitcoin-cli getrawtransaction "$txid" true | jq -r '.vin[] | select(.txid == "'$coin'")')
  if [ ! -z "$vins" ]; then
    echo $txid
    exit
  fi
done
