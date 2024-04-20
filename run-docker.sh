#!/usr/bin/env bash


set -e

docker compose down

cd backend

./build-image.sh

cd ..

cd frontend

./build-image.sh

cd ..

./bootstrap-cardano-db.sh

docker compose build --pull backend

docker compose build --pull frontend

docker compose up -d  --pull always
