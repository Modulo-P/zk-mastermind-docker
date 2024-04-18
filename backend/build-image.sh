#! /bin/bash

# Delete the 'repo' directory if it exists
if [ -d "repo" ]; then
    rm -rf repo
fi

git clone https://github.com/Modulo-P/zk-mastermind-backend repo

cd repo
git checkout plutusv2
cd ..
