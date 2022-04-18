#!/bin/bash

export FILE_KEY=Masterkey123

cd $HOME/Downloads/
unzip install-dir.tar.gz.enc.zip
openssl enc -aes-256-cbc -d -a -pbkdf2 -k ${FILE_KEY} -in "install-dir.tar.gz.enc" -out "install-dir.tar.gz"
mkdir install-dir
tar zxvf "install-dir.tar.gz" -C install-dir
export KUBECONFIG=$HOME/Downloads/install-dir/auth/kubeconfig
