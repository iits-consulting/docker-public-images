#!/usr/bin/env bash

set -e
set -x

find . -mindepth 1 -maxdepth 1 -type d -not -name "\.*" | sed -e '/^$/d' > docker_images_list.txt

while read -r docker_image
do
  # shellcheck disable=SC2164
  cd "$docker_image"

  docker build -q -t test-build-image .

  # shellcheck disable=SC2103
  cd ..
done < docker_images_list.txt

rm docker_images_list.txt




