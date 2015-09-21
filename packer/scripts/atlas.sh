#! /usr/bin/env sh

# Update Packages and Install Go
# apt-get update
# apt-get install golang

# Set GOPATH
# export GOPATH="/usr/share/go/"

# Get Atlas Upload CLI
# cd ..
# git clone https://github.com/hashicorp/atlas-upload-cli.git
# cd atlas-upload-cli
# make
# cd ../fresh-food-connect-api

# Upload Rails Application to Atlas
# ../atlas-upload-cli/bin/atlas-upload -vcs -debug codefordenver/fresh-food-connect .

# Use Travis CI's dpl to Push to Atlas
# dpl --provider=atlas --token=ATLAS_TOKEN --app=ATLAS_USERNAME/APP_NAME --debug --vcs --version