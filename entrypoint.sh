#!/bin/sh

RUNNER_NAME=python3.9-runner-$(uuidgen)
RUNNER_DIR=$HOME/actions-runner
RUNNER_WORK_DIR=$HOME/_work
RUNNER_CONFIG_CMD="$RUNNER_DIR/bin/Runner.Listener configure"

cd $RUNNER_DIR

if [ -z $GITHUB_REPO_URL ]; then
        echo "error: GITHUB_REPO_URL environment variable not set!" >&2
        exit 1
fi
if [ -z $GITHUB_RUNNER_TOKEN ]; then
        echo "error: GITHUB_RUNER_TOKEN environment variable not set!" >&2
        exit 1
fi

$RUNNER_CONFIG_CMD \
        --unattended \
        --url $GITHUB_REPO_URL \
        --token $GITHUB_RUNNER_TOKEN \
        --name $RUNNER_NAME \
        --work $RUNNER_WORK_DIR
if [ $? -ne 0 ]; then
        echo "error: Runner configuration failed."
        exit 1
fi

./run.sh
