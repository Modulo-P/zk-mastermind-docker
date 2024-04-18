#!/usr/bin/env bash


set -e

docker compose down

cd backend

./build-image.sh

cd ..

docker compose build --pull backend

docker compose up -d  --pull always
