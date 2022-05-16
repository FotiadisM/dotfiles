#! /bin/env bash

set -ux

go_version=$(wget --no-check-certificate -qO- https://golang.org/dl | grep -oP "go([0-9\.]+)\.linux-amd64\.tar\.gz" | head -n 1)
wget https://go.dev/dl/$go_version -O /tmp/$go_version
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/$go_version
