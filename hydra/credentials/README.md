# Credentials

The solution needs some credentials and scripts for woriking. These steps guide you through the process:

1. Execute the command `generate-credentials.sh`. This output is an example after the execution of the script.

```
Generating credentials for cardano-funds-1
Generating credentials for cardano-funds-2
Generating credentials for cardano-node-1
Generating credentials for cardano-node-2
Generating credentials for hydra-node-1
Generating credentials for hydra-node-2
Generating credentials for bridge


Please, add this variable to your backend_env file:

FUNDS_WALLET_PRIVATE_KEY=5820261599fc2ed767088d7a747fca7d8a655400d598df991c398aabb1c8a159b904
BLOCKFROST_PROJECT_ID=#your_blockfrost_project_id#


Pubkey hash for the minting contract:

Pubkey hash cardano-funds-1.vk: 12c52ee348f564b39ae380d1c537dfc58cd6b8192c009c5a208aec7d
```

2. Add the environment variables for the backend in the `.backend_env`file on the root of the repository.
3. Compile the minting contract from [zk-mastermind-backend-onchain](https://github.com/Modulo-P/zk-mastermind-backend-onchain) and get the plutus validator. You'll need the pubkey hash from the cardano-funds-1 displayed in the `generate-credentials.sh` script.

```
$ nix develop
$ cabal build all
$ cabal exec backend-onchain-exe 12c52ee348f564b39ae380d1c537dfc58cd6b8192c009c5a208aec7d
```

The file `validator.plutus`is generated in the root of the zk-mastermind-backend-onchain repository. You'll need to put this validator in the `.backend_env`file.

```
(example)
MINTING_CONTRACT=590a15590a120100003323233223322323322323232323.....
```
