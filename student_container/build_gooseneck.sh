## @details To build container, use
## docker build --progress=plain -t student_img . | tee logs/build/student_img.log
##
## Include --no-cache for a full build and verbose log

#Check for no cache option
if [[ $1 == "--no-cache" ]]; then
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
