#!/usr/bin/env bash
set -eux -o pipefail

vagrant up
vagrant halt
vagrant package --output temp/box.box
vagrant destroy --force

# Convert Vagrant .box file to OVA file.
cd temp
tar --extract --file box.box
rm box.box
tar --create --file box.ova -- *.ovf *.vmdk
mv box.ova ../opensuse-dev-box.ova
cd ..
rm --recursive --force temp
