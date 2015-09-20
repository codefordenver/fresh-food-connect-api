#! /usr/bin/env sh

# Update Packages and Install Go
# apt-get update
# apt-get install golang

# Get Atlas Upload CLI
cd ..
git clone https://github.com/hashicorp/atlas-upload-cli.git
cd atlas-upload-cli
make
cd ../fresh-food-connect-api

# Upload Rails Application to Atlas
../atlas-upload-cli/bin/atlas-upload -vcs -debug codefordenver/fresh-food-connect .