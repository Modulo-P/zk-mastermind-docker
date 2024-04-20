# Credentials

The solution needs some credentials and scripts for woriking. These steps guide you through the process:

1. Execute the command `generate-credentials.sh`. This output is an example after the execution of the script.

```
Generating credentials for cardano-funds-1
Generating credentials for cardano-funds-2
Generating credentials for cardano-node-1
Generating credentials for cardano-node-2

Please, add this variable to your backend_env file:

FUNDS_WALLET_PRIVATE_KEY=5820261599fc2ed767088d7a747fca7d8a655400d598df991c398aabb1c8a159b904
BLOCKFROST_PROJECT_ID=#your_blockfrost_project_id#


Pubkey hash for the minting contract:

Pubkey hash cardano-funds-1.vk: 12c52ee348f564b39ae380d1c537dfc58cd6b8192c009c5a208aec7d


Cardano bridge address:

Address for Kupo: addr_test1wqztzth07h4hz77ueck3wdxah3xatz45xsgq69gmm7g9kngdnuhyf
```

2. Add the environment variables for the backend in the `.backend_env`file on the root of the repository.
3. Compile the minting contract from [zk-mastermind-backend-onchain](https://github.com/Modulo-P/zk-mastermind-backend-onchain) and get the plutus validator. You'll need the pubkey hash from the cardano-funds-1 displayed in the `generate-credentials.sh` script.

```
$ nix develop
$ cabal build all
$ cabal exec backend-onchain-exe 12c52ee348f564b39ae380d1c537dfc58cd6b8192c009c5a208aec7d
```

```
PubKeyHash: c1921bf5253ed0d2c6f721cd8968e554be30f6fe68f18621968c518f
Success
Wrapped ADA asset id: fac955f6da18b98227061bf005b3351d4c3a6e11a1170f98bd459f8e48796472414441
```

The file `validator.plutus`is generated in the root of the zk-mastermind-backend-onchain repository. You'll need to put this validator in the `.backend_env`file.

```
(example)
MINTING_CONTRACT=590a15590a120100003323233223322323322323232323.....
```

4. The last configuration is to set Kupo for indexing the Cardano bridge address. You can find the address at the last part of the `generate-credentials.sh`and you'll need to put it in the `kupo/docker-compose.yaml`file in the line 21

```
    ...
       "--defer-db-indexes",
        "--prune-utxo",
        "--match",
        "addr_test1wqztzth07h4hz77ueck3wdxah3xatz45xsgq69gmm7g9kngdnuhyf"
      ]
    ...
```
