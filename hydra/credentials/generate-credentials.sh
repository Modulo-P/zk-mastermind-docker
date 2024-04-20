#! /bin/bash

POSTGRES_PASSWORD=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10)
: '
for CREDENTIAL in cardano-funds-1 cardano-funds-2 cardano-node-1 cardano-node-2
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
'

FUNDS_WALLET_PUB_KEY_HASH=$(cardano-cli address key-hash --payment-verification-key-file cardano-funds-1.vk)
FUNDS_WALLET_ADDRESS=$(cardano-cli address build --payment-verification-key-file cardano-funds-1.vk --testnet-magic 1)

echo "{
    \"keyHash\": \"$FUNDS_WALLET_PUB_KEY_HASH\",
    \"type\": \"sig\"
}" > escrow.script
ESCROW_ADDRESS=$(cardano-cli address build --payment-script-file escrow.script --testnet-magic 1)
FUNDS_WALLET_PRIVATE_KEY=$(jq -r ".cborHex" cardano-node-1.sk)

sed "s/#PUBKEY_HASH#/$FUNDS_WALLET_PUB_KEY_HASH/g" minting-contract.template > minting-contract.plutus
MINTING_CONTRACT=$(jq -r ".cborHex" minting-contract.plutus)
NEXT_PUBLIC_HYDRA_ASSET_ID="$(cardano-cli transaction policyid --script-file minting-contract.plutus)48796472414441"



echo "Creating .env file"
echo "CARDANO_BRIDGE_ADDRESS=$ESCROW_ADDRESS
POSTGRES_PASSWORD=$POSTGRES_PASSWORD" > ../../.env

echo "Creating .backend_env file"
echo "Please enter your Blockfrost project id. You can get your free project id for preprod in http://blockfrost.io"
read BLOCKFROST_PROJECT_ID

echo "PORT=3004
HYDRA_NODE_1_HOST=hydra-node-1:4001
HYDRA_NODE_2_HOST=hydra-node-2:4001
KUPO_URL=http://kupo:1442
DATABASE_URL="postgresql://postgres:$POSTGRES_PASSWORD@db:5432/mastermind?schema=public"
FUNDS_WALLET_PRIVATE_KEY=$FUNDS_WALLET_PRIVATE_KEY
MINTING_CONTRACT=$MINTING_CONTRACT
BLOCKFROST_PROJECT_ID=$BLOCKFROST_PROJECT_ID" > ../../.backend_env


echo "Creating .frontend_env file"
echo "NEXT_PUBLIC_HYDRA_BACKEND=http://backend:3004
NEXT_PUBLIC_CARDANO_BRIDGE_ADDRESS=$ESCROW_ADDRESS
NEXT_PUBLIC_CARDANO_FUNDS_1_ADDRESS=$FUNDS_WALLET_ADDRESS
NEXT_PUBLIC_HYDRA_ASSET_ID=$NEXT_PUBLIC_HYDRA_ASSET_ID
NEXT_PUBLIC_MINTING_CONTRACT=$MINTING_CONTRACT" > ../../.frontend_env