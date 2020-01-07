#!/bin/bash
GIT_FOLDER=$1
OUTPUT_FOLDER="/build"

if [ -z "$GIT_FOLDER" ]; then
    echo "git folder not provided"
    exit 1
fi

cd $GIT_FOLDER

git fetch
# Get the number of commits
CHANGES=$(git log ..origin/master --oneline | wc -l)
echo "Detected changes: ${CHANGES}"

# Pull and build the changes if one or more of the following is true:
# 1. There are changes to pull
# 2. Output folder does not exist (i.e. static files weren't built yet)
# 3. Output folder exists, but it's empty (K8S mounts an empty folder)
if [ "$CHANGES" -gt "0" ] || [ ! -d "$OUTPUT_FOLDER" ] || [[ ! $(ls -A "$OUTPUT_FOLDER") ]]; then
    echo "Pulling new changes and rebuilding ..."
    git reset --hard
    git pull

    # Build everything
    npm run build

    # Move the build contents to the output folder
    cp -a build/. $OUTPUT_FOLDER
    echo "Build completed."
fi