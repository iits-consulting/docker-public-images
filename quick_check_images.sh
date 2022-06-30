#!/usr/bin/env bash

set -e
set -o pipefail

PLATFORM_ARG=""
if [ "$(uname -m)" == "arm64" ]; then
  PLATFORM_ARG="--platform linux/amd64"
fi

find . -mindepth 1 -maxdepth 1 -type d -not -name "\.*" | sed -e '/^$/d' | while read -r docker_image
do
  # shellcheck disable=SC2164
  cd "$docker_image"
  echo "Checking $docker_image"

  hadolint Dockerfile

  # word splitting is on purpose here
  # shellcheck disable=SC2086
  docker build -q $PLATFORM_ARG -t test-build-image .

  # shellcheck disable=SC2103
  cd ..
done



