# zk-mastermind-docker

## Overview

This repository contains the docker compose files for the infraestructure of the ZK Mastermind game.

## Prerequisites

- Docker 24.0.7 or higher
- Cardano CLI

## Run

The command `run-docker.sh`take care of al the solution configuration. The current user must be in the docker group [How to add current user to docker group](https://docs.docker.com/engine/install/linux-postinstall/).

```
$ ./run-docker.sh
```

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
