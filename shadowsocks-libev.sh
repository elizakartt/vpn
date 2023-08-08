#!/bin/bash
# Pure Compilation of Shadowsocks-libev for Debian / Ubuntu / Centos 7

if [ -e /etc/debian_version ];then
    ## install base soft
    apt update && apt install -y ca-certificates wget curl unzip vim htop tmux

    ## Debian / Ubuntu   build-essential
    apt install -y git gettext build-essential autoconf libtool automake
else
    ## Centos  Development Tools
    yum update -y  && yum install -y ca-certificates wget curl unzip vim htop tmux
    yum groupinstall "Development Tools" -y
    yum install -y git gettext autoconf libtool automake
fi

# Installation of [ asciidoc xmlto c-ares-devel libev-devel ]
mkdir -p ~/libev_ss  &&  cd ~/libev_ss

wget https://jaist.dl.sourceforge.net/project/asciidoc/asciidoc/8.6.9/asciidoc-8.6.9.zip
unzip asciidoc-8.6.9.zip
cd asciidoc-8.6.9
./configure
make
make install

cd ~/libev_ss

wget http://deb.debian.org/debian/pool/main/p/pcre3/pcre3_8.35.orig.tar.gz
tar xf pcre3_8.35.orig.tar.gz
cd pcre-8.35
./configure
make
make install

cd ~/libev_ss

wget https://releases.pagure.org/xmlto/xmlto-0.0.28.tar.gz
tar xf xmlto-0.0.28.tar.gz
cd xmlto-0.0.28
./configure
make
make install

cd ~/libev_ss

wget https://c-ares.haxx.se/download/c-ares-1.15.0.tar.gz
tar xf c-ares-1.15.0.tar.gz
cd c-ares-1.15.0
./configure
make
make install

cd ~/libev_ss

wget http://deb.debian.org/debian/pool/main/libe/libev/libev_4.22.orig.tar.gz
tar xf libev_4.22.orig.tar.gz
cd libev-4.22/
./configure
make
make install

cd ~/libev_ss

# Installation of MbedTLS
wget http://deb.debian.org/debian/pool/main/m/mbedtls/mbedtls_2.16.0.orig.tar.xz
tar xf mbedtls_2.16.0.orig.tar.xz
cd mbedtls-2.16.0/
make
make install

cd ~/libev_ss

# Installation of libsodium
git clone https://github.com/jedisct1/libsodium --depth=1
cd libsodium/
./autogen.sh
./configure
make
make install

# configure dynamic linker run time bindings
ldconfig
cd ~

# Start building Shadowsocks-libev
git clone --recursive https://github.com/shadowsocks/shadowsocks-libev --depth=1
cd shadowsocks-libev
git submodule update --init --recursive
./autogen.sh
./configure
make
make install

/usr/local/bin/ss-server -v
############################
