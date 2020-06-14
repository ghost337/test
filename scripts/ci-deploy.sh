#!/usr/bin/env bash
# exit script when any command ran here returns with non-zero exit code
set -e

echo "hello world 123!"

envsubst <./docker-compose.yml >./docker-compose.yml.out
mv ./docker-compose.yml.out ./docker-compose.yml

scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -P${SSH_PORT} docker-compose.yml ${DO_USER}@${DO_HOST}:~/projects/
ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p${SSH_PORT} ${DO_USER}@${DO_HOST} 'docker-compose -f ~/projects/docker-compose.yml pull'
ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -p${SSH_PORT} ${DO_USER}@${DO_HOST} 'docker-compose -f ~/projects/docker-compose.yml up -d --no-build'
