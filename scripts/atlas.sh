#! /usr/bin/env sh

# Update Packages and Install Go
sudo apt-get update
sudo apt-get install golang

# Get Atlas Upload CLI
cd ..
git clone https://github.com/hashicorp/atlas-upload-cli.git
cd atlas-upload-cli
make
cd ../fresh-food-connect-api

# Upload Rails Application to Atlas
../atlas-upload-cli/bin/atlas-upload codefordenver/fresh-food-connect .