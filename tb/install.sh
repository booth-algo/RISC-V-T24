#!/bin/bash

# This script installs the dependencies for the testbench

# Usage: ./install.sh

# Author: William Huynh <wh1022@ic.ac.uk>

sudo apt update
sudo apt-get install -y libgtest-dev lcov gcc-riscv64-unknown-elf

sudo apt-get install -y help2man perl make g++ git autoconf libunwind-dev
sudo apt-get install -y python3 flex bison ccache
sudo apt-get install -y libgoogle-perftools-dev numactl perl-doc
sudo apt-get install -y libfl2
sudo apt-get install -y libfl-dev
sudo apt-get install -y zlibc zlib1g zlib1g-dev


# Install verilator unless stated otherwise
if command -v "verilator" > /dev/null; then
    verilator --version
    echo "[install] Please check that the version number >= v4.226"
    echo "[install] Otherwise, please remove verilator and rerun this script"
else
    echo "[install] Installing Verilator"
    cd /tmp
    rm -rf verilator

    git clone https://github.com/verilator/verilator verilator
    cd verilator
    git checkout v4.226
    autoconf
    ./configure
    make -j "$(nproc)"
    sudo make install
    cd ..
    rm -rf verilator
fi
