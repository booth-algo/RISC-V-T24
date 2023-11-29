#!/bin/bash

# Usage: ./compile.sh <file.S>
# Author: pykcheung, modified by William Huynh <wh1022@ic.ac.uk>


# Default vars
input_file="program.S"
output_file="../rtl/program.hex"


# Handle terminal arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--input)
            input_file="$2"
            shift
            ;;
        -o|--output)
            output_file="$2"
            shift
            ;;
        *)
            echo "Error: Unknown option $1" >&2
            echo "Run compile.sh --help for usage options"
            exit 1
            ;;
    esac
    shift
done


riscv64-unknown-elf-as -R -march=rv32im -mabi=ilp32 \
                        -o "a.out" "${input_file}"

riscv64-unknown-elf-ld -melf32lriscv \
                        -e 0xBFC00000 \
                        -Ttext 0xBFC00000 \
                        -o "a.out.reloc" "a.out"

rm "a.out"

riscv64-unknown-elf-objcopy -O binary \
                            -j .text "a.out.reloc" "a.bin"

rm "a.out.reloc"

# Formats into a hex file
od -v -An -t x1 "a.bin" | tr -s '\n' | awk '{$1=$1};1' > "${output_file}"

rm "a.bin"
