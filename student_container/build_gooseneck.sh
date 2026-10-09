#!/bin/bash
## @file build_gooseneck.sh
## @brief Build the Docker image used to create Gooseneck student containers.
## @details This script builds the student_img image from the local Dockerfile.
##          Use --no-cache to force a full rebuild without Docker's layer cache.
##          Build output is redirected to logs/build/student_img.log for review.
## @warning The build process may take several minutes depending on the system.

## Check whether the build should skip Docker cache and perform a full rebuild.
if [[ "$1" == "--no-cache" ]]; then
  echo "Attempting to build student_img from Dockerfile... Rejecting Cache!!! (This could take a while...)"
  docker build --no-cache --progress=plain -t student_img . | tee logs/build/student_img.log
  exit 0
elif [[ $# -gt 0 ]]; then
  echo "Invalid argument passed. Aborting..."
  exit 1
else
  echo "Attempting to build student_img from Dockerfile... Using cache if applicable..."
  docker build --progress=plain -t student_img . | tee logs/build/student_img.log
  exit 0
fi
