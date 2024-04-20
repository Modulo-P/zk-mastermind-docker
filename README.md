# zk-mastermind-docker

## Overview

This repository contains the docker compose files for the infraestructure of the ZK Mastermind game.

## Prerequisites

- Docker 24.0.7 or higher

## Setup

You'll need to set up some credentials and password before to deploy the solution:

1. Create a copy of the `.backend_env.example`as `.backend_env`in the root of the repository.
2. Set a password for the postgres database. In the file `.backend_env`, you'll need to replace the #GENERATE_PASSWORD# with a secure password and go to the `docker-compose.yaml`file and in the line 12 set this password for the Postgres service.
3. Go to the file `hydra/credentials/README.md` and follow the instruction to set up the Cardano and Hydra credentials.

## Run

In order to have the solution running you'll need to put funds in the cardano-funds-1, cardano-funds-2, cardano-node-1 and cardano-node-2 address from the credentials directory

When all the credentials and docker files are configured you can start the solution running the following command: 

```
$ ./run-docker.sh
```

The first time, you'll need to wait to the cardano node synchronization. Alternatively, you can download the last preprod snapshot with Mithril. Here you have a tutorial from the Hydra team [Tutorial](https://hydra.family/head-protocol/docs/tutorial/).

Once you run the `run-docker.sh`script for the first time you can start and stop the solution with these commands.

```
# Start all containers
$ docker compose up -d

# Stop all
$ docker compose down 
```

## Appendix: Dapp repositories

The relevant repositories of the mastermind Dapp are as follows:

1. [zk-mastermind-webdapp:](https://github.com/Modulo-P/zk-mastermind-webapp) Frontend application of the Mastermind Dapp.
2. [zk-mastermind-backend:](https://github.com/Modulo-P/zk-mastermind-backend) Backend application of the Mastermind Dapp.
3. [zk-mastermind-backend-onchain:](https://github.com/Modulo-P/zk-mastermind-backend-onchain) Hada mint contrat of the Mastermind Dapp.
4. [zk-mastermind-docker:](https://github.com/Modulo-P/zk-mastermind-docker) Docker container with the Kupo, Hydra and Cardano node components of the Dapp.
5. [zk-mastermind-circom:](https://github.com/Modulo-P/zk-mastermind-circom) Circom circuits of the mastermind Dapp.
6. [zk-mastermind-plutus:](https://github.com/Modulo-P/zk-mastermind-plutus) PlutusTx validator that implements the logic of the game.
7. [zk-mastermind-aiken:](https://github.com/Modulo-P/zk-mastermind-aiken) Aiken validator that implements the logic of the game.
