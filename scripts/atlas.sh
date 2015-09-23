#! /usr/bin/env sh

set -ex
pwd
ls -la
mkdir ../tmp
cd ../tmp
wget https://github.com/hashicorp/atlas-upload-cli/releases/download/v0.2.0/atlas-upload-cli_0.2.0_linux_amd64.tar.gz
tar -xzvf atlas-upload-cli_0.2.0_linux_amd64.tar.gz
cd ../fresh-food-connect-api
git checkout -
git branch
git symbolic-ref HEAD
./../tmp/atlas-upload-cli_0.2.0_linux_amd64/atlas-upload -vcs -debug codefordenver/freshfoodconnect .






# # Update Packages and Install Go
# # apt-get update
# # apt-get install golang

# # Set GOPATH
# export GOPATH="/usr/share/go/"

# # Get Atlas Upload CLI
# cd ..
# git clone https://github.com/hashicorp/atlas-upload-cli.git
# cd atlas-upload-cli
# make
# cd ../fresh-food-connect-api

# # Upload Rails Application to Atlas
# ../atlas-upload-cli/bin/atlas-upload -vcs -debug codefordenver/fresh-food-connect .