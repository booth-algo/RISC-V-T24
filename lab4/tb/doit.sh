#!/bin/bash

# This script runs the testbench
# Author: William Huynh <wh1022@ic.ac.uk>


# Constants
TEST_FOLDER="test"
RTL_FOLDER="../rtl"
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Variables
data_files=()
passes=0
fails=0


# Cleanup
rm -rf obj_dir

for file in ${TEST_FOLDER}/*_tb.cpp; do
    name=$(basename "$file" _tb.cpp)

    # Translate Verilog -> C++ including testbench
    verilator   -Wall --coverage --trace \
                -cc ${RTL_FOLDER}/${name}.sv \
                --exe ${TEST_FOLDER}/${name}_tb.cpp \
                --prefix "Vdut" \
                -o Vdut \
                -CFLAGS "-fprofile-generate" \
                -LDFLAGS "-lgtest -lpthread -fprofile-generate" \

    # Build C++ project with automatically generated Makefile
    make -j -C obj_dir/ -f Vdut.mk

    # Run executable simulation file
    ./obj_dir/Vdut
    
    # Check if the test succeeded or not
    if [ $? -eq 0 ]; then
        ((passes++))
    else
        ((fails++))
    fi
    
    # Add file pointer of coverage data file to array
    data_files+=( "logs/coverage_${name}.dat" )
done

# Generate code coverage data.
# The [*] is to expand the array to space separated elements
verilator_coverage  --annotate logs/annotate \
                    --annotate-all --annotate-min 1 \
                    -write-info logs/merged.info ${data_files[*]}

# Create a HTML code-coverage report using LCOV
genhtml logs/merged.info --output-directory logs/html

# Exit as a pass or fail (for CI purposes)
if [ $fails -eq 0 ]; then
    echo "${GREEN}Success! All ${passes} test(s) passed!"
    exit 0
else
    total=$((passes + fails))
    echo "${RED}Failure! Only ${passes} test(s) passed out of ${total}."
    exit 1
fi