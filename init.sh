#!/bin/bash

if [ -z "$GITHUB_REPO" ]; then
    echo "Please provide a Github repo URL"
    exit 1
fi

if [ -z "$POLL_INTERVAL" ]; then
    POLL_INTERVAL="30"
fi

CODE_DIR="code"

echo "Cloning repo '$GITHUB_REPO'"
git clone $GITHUB_REPO $CODE_DIR
cd $CODE_DIR

echo "Running 'npm install'"
npm install
cd ..

echo "Watching for code changes"
while true; do
    ./build.sh $CODE_DIR
    echo "Sleep for $POLL_INTERVAL"
    sleep $POLL_INTERVAL
done