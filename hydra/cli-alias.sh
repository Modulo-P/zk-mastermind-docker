alias cardano-cli="docker run --rm -it  \
    -e CARDANO_NODE_SOCKET_PATH=/ipc/node.socket \
    -v /home/juan/workspace/zk-mastermind-docker/hydra/node:/ipc   \
    inputoutput/cardano-node:8.1.2 cli"