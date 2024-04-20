#!/usr/bin/env bash


set -e

echo "Bootstraping ZK Mastermind solution"

docker compose down

cd backend

./build-image.sh

cd ..

cd frontend

./build-image.sh

cd ..

./bootstrap-cardano-db.sh

cd hydra/credentials

./generate-credentials.sh

cd ..
cd ..

docker compose build --pull backend

docker compose build --pull frontend

docker compose up -d  --pull always

echo "
Please add funds to this address:

Cardano funds 1 address (~1000 tADA): $(cat hydra/credentials/cardano-funds-1.addr)
Cardano funds 2 address (~100 tADA): $(cat hydra/credentials/cardano-funds-2.addr)
Cardano node 1 address (~1000 tADA): $(cat hydra/credentials/cardano-node-1.addr)
Cardano node 2 address (~100 tADA): $(cat hydra/credentials/cardano-node-2.addr)

Once the funds are in the addresses you can check if the Hydra head is open:

docker compose logs -f -n 1000 backend 
"