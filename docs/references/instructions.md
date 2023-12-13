# References

## Testing instructions

### Compiling code

To compile your RISC-V assembly (.s) or C code (.c), use the `compile.sh` 
script in the tesbench.

```bash
cd tb
# Specify file location (replace asm/file.s with path)
./compile.sh --input <asm/file.s>
```

This will also generate a **disassembly** file. This contains human-readable 
information on the program that you have just compiled.

This will create a **hex** file. Default: `rtl/program.hex`.

The default location for the file is `tb/asm/<filename>.dis.txt`.

### Validating tests

To get the expected output of the files under `c/`, you can compile and run it
locally

```bash
gcc -o <program> <program.c>
./program

# Recommended but not essential
rm program
```

### Running tests

To run the test suite, run `doit.sh`.

```bash
cd tb

# Run the entire test suite
./doit.sh                   

# Run a singular test (replace test/test.cpp with path)
./doit.sh <test/test.cpp>   
```

### Viewing waveforms

Some tests can generate a waveform. To view the waveform:

```bash
gtkwave waveform.vcd
```

### Viewing code coverage

Tests generate a code coverage report. To view the code coverage,
navigate to: `tb/logs/html/index.html`.

You can open the file on Google Chrome or another web browser.

## Git instructions (creating new branch)
- Switch to main before deleting
- Delete: `git branch -d <branch_name>`
- Make new branch:
  - `git checkout main`
  - `git pull`
  - `git branch <new_branch_name>`
- Rename branch:
  - `git checkout <branch_you_want_to_rename>`
  - `git branch -m <new_branch_name>`
- Branch from current main:
  - `git branch -b <branch_name>`

## RISC-V calling conventions
![Alt text](../images/calling_convention.png)

## Cache (Two-way set associative)
![Alt text](<../images/cache.png>)