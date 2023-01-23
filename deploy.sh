#!/bin/bash

docker tag "${IMAGE_NAME}:latest" "${REPOSITORY}/${IMAGE_NAME}:latest"
docker tag "${IMAGE_NAME}:latest" "${REPOSITORY}/${IMAGE_NAME}:${TRAVIS_TAG}"
docker login --username "${REPOSITORY_USERNAME}" --password-stdin "${REPOSITORY}" < repository_password
docker image push --all-tags "${REPOSITORY}/${IMAGE_NAME}"
