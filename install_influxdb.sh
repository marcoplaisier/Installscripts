#!/bin/bash
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /root/.gvm/scripts/gvm
apt-get install bison -y
gvm install go1.4
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.5
gvm use go1.5 --default
apt-get install ruby-dev gcc -y
gem install fpm

gvm pkgset create influxdb
gvm pkgset use influxdb

echo "Checkout sources"
mkdir -p ~/.gvm/pkgsets/go1.5/influxdb/src/github.com/influxdb
cd ~/.gvm/pkgsets/go1.5/influxdb/src/github.com/influxdb
git clone https://github.com/influxdb/influxdb.git


echo "Build debian package"
cd influxdb
./package.sh -t deb -p 0.9.4

echo "Install package"
dpkg -i influxdb_0.9.4_armhf.deb

echo "Start server"
service influxdb start

echo "Test server"
/opt/influxdb/influx
