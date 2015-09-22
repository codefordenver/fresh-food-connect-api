#! /usr/bin/env sh

set -ex
wget https://github.com/hashicorp/atlas-upload-cli/releases/download/v0.2.0/atlas-upload-cli_0.2.0_linux_amd64.tar.gz -O /tmp/atlas-upload-cli.tar.gz
tar -xzvf /tmp/atlas-upload-cli.tar.gz
ls /tmp/atlas-upload-cli
./tmp/atlas-upload-cli/atlas-upload -vcs -debug codefordenver/fresh-food-connect .





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