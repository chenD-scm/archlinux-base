#!/bin/bash
cmd=$1
#if [ -d "$(`dirname "$0"`)/tmp"];then
#    echo "0"
#    rm -r $(dirname $0)/tmp
#fi

git_clone() {
    git clone git@github.com:cisco/ChezScheme git/ChezScheme
}

pkg_build() {
    echo ""
}

mkdir $(dirname $0)/git
git_clone
