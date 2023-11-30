#!/bin/bash

# Usage: ./compile.sh <file.s>
# Author: pykcheung, modified by William Huynh <wh1022@ic.ac.uk>


# Default vars
input_file="program.s"
output_file="../rtl/program.hex"


function display_help() {
  cat <<EOF
Usage: script.sh [--input INPUT_FILE] [--output OUTPUT_FILE] [--help]

Options:
    -i, --input     Specify input file (.s or .c)
    -o, --output    Specify output file
    -h, --help      Show this help message
EOF
}

# Handle terminal arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            display_help
            exit 0
            ;;
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


basename=$(basename "$input_file" | sed 's/\.[^.]*$//')
file_extension="${input_file##*.}"

# Compile the C code if necessary
if [ $file_extension == "c" ]; then
    riscv64-unknown-elf-gcc -S -march=rv32im -mabi=ilp32 \
                            -o "asm/${basename}.s" $input_file
    input_file="asm/${basename}.s"
fi

riscv64-unknown-elf-as -R -march=rv32im -mabi=ilp32 \
                        -o "a.out" "${input_file}"

riscv64-unknown-elf-ld -melf32lriscv \
                        -e 0xBFC00000 \
                        -Ttext 0xBFC00000 \
                        -o "a.out.reloc" "a.out"

rm "a.out"

riscv64-unknown-elf-objcopy -O binary \
                            -j .text "a.out.reloc" "a.bin"

rm asm/*dis.txt

# This generates a disassembly file in the asm folder
riscv64-unknown-elf-objdump -D -b binary \
                            -m riscv a.bin > asm/${basename}.dis.txt

rm "a.out.reloc"

# Formats into a hex file
od -v -An -t x1 "a.bin" | tr -s '\n' | awk '{$1=$1};1' > "${output_file}"

rm "a.bin"
