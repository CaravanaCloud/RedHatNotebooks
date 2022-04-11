#!/bin/bash

export FILE_KEY=Masterkey123

cd $HOME/Downloads/
unzip install-dir.tar.gz.enc.zip
openssl enc -e -a -aes256 -pbkdf2 -k ${FILE_KEY} -d -in "install-dir.tar.gz.enc" -out "install-dir.tar.gz"
