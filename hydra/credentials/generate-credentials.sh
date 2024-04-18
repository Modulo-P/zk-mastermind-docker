#! /bin/bash


for CREDENTIAL in cardano-funds-1 cardano-funds-2 cardano-node-1 cardano-node-2 hydra-node-1 hydra-node-2 bridge
do
    echo "Generating credentials for $CREDENTIAL"
    
    cardano-cli address key-gen \
    --verification-key-file $CREDENTIAL.vk \
    --signing-key-file $CREDENTIAL.sk 

    cardano-cli address build \
    --verification-key-file $CREDENTIAL.vk \
    --out-file $CREDENTIAL.addr \
    --testnet-magic 1

done

echo "{
    \"keyHash\": \""$(cardano-cli address key-hash --payment-verification-key-file bridge.vk)"\",
    \"type\": \"sig\"
}" > escrow.script

cardano-cli address build --payment-script-file escrow.script --testnet-magic 1 > escrow.addr

echo  -e "\n\nPlease, add this variable to your backend_env file: \n"
echo "FUNDS_WALLET_PRIVATE_KEY=$(jq -r ".cborHex" cardano-node-1.sk)"
echo "BLOCKFROST_PROJECT_ID=#your_blockfrost_project_id#"


echo -e "\n\nPubkey hash for the minting contract:\n"
echo "Pubkey hash cardano-funds-1.vk: $(cardano-cli address key-hash --payment-verification-key-file cardano-funds-1.vk)"
