#!/bin/bash

# This script runs the testbench
# Author: William Huynh <wh1022@ic.ac.uk>

readonly NAME="cpu"

# Cleanup
rm -rf obj_dir
rm -f waveform.vcd

# Translate Verilog -> C++ including testbench
verilator -Wall --coverage --trace \
            -cc ${NAME}.sv \
            --exe ${NAME}_tb.cpp \
            -o V${NAME} \
            -CFLAGS "-fprofile-generate" \
            -LDFLAGS "-lgtest -lpthread -fprofile-generate" \

# Build C++ project with automatically generated Makefile
make -j -C obj_dir/ -f V${NAME}.mk

# Run executable simulation file
./obj_dir/V${NAME}

# Generate code coverage data
verilator_coverage --annotate logs/annotate \
                    --annotate-all --annotate-min 1 \
                    -write-info logs/merged.info logs/coverage.dat

# Create a HTML code-coverage report using LCOV
genhtml logs/merged.info --output-directory logs/html