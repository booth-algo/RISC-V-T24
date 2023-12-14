# References

## Testing instructions

### Getting started

Most of the time you will only need to run tests.

### Running tests

To run the test suite, run `doit.sh`.

```bash
cd tb

# Run the entire test suite
./doit.sh                   

# Run a singular test (replace test/test.cpp with path)
./doit.sh <test/test.cpp>   
```

### Validating tests

To get the expected output of the files under `c/`, you can compile and run it
locally

```bash
gcc -o <program> <program.c>
./program

# Recommended but not essential
rm program
```

### Viewing waveforms

Some tests can generate a waveform. To view the waveform:

```bash
# Opens up gtkWave in a new window
gtkwave waveform.vcd
```

Note: there may be seperate test cases in one testbench. If you want to see the
waveforms for one file, it is essential to comment out other test cases so that
the right waveforms are generated.

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

### Viewing code coverage

Tests generate a code coverage report. To view the code coverage,
navigate to: `tb/logs/html/index.html`.

You can open the file on Google Chrome or another web browser.

## Explanation of the testbench

In `.github/workflows/main.yml`, there is a typical use scenario for the
testbench.

The testbench uses GoogleTest (`libgtest-dev`), a framework.

Instruction tests are written in `tb/c`. They are invoked in 
`test/top-instr_tb.cpp`, via the `doit.sh` script (see above).

Individual unit tests are written in `test/`, except the tests that are 
prefixed with "top". 

### How do I write a test?

If you are writing a unit test (testing a component):

For this example, assume the unit is called `unit_to_test.sv`.

1. Create a testbench under `test/` called `unit_to_test_tb.cpp`.
2. Populate the file with the necessary initilization. It is often
easier to just copy from an existing testbench. Here is an example:

```cpp
// Use SyncTestbench instead of BaseTestbench for CLOCKED units 
class ALUTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        // Your .sv initial inputs go here. e.g.
        top->input1 = 0;      
    }
};


TEST_F(ALUTestbench, MyTest)
{
    // Put your test here e.g. Change inputs, eval 
    
    // Note: use one of the following to drive your DUT.
    top->eval();        // Non-clocked 
    runSimulation();    // Clocked

    // Now this will generate a pass or fail.
    EXPECT_EQ(result, expected_result);
}


// No need to to change any of this- this can be left as is
int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    VerilatedCov::write(("logs/coverage_" + std::string(NAME) + ".dat").c_str());

    return res;
}

```

If you are writing an integration test (top level test):

1. Create a file (prefixed) under `c/` or `asm/`, depending on the preferred
programming language. Find examples there, they are well-documentated.
2. Navigate to `top-instr_tb.cpp`. Add a test similar to this, to the bottom
of the test suite (if you want to see the waveforms on failure).

```cpp
TEST_F(CpuTestbench, LB_and_SB_Test)
{
    // Call the bash terminal from inside the C program
    system("./compile.sh --input asm/006-lb-lbu-sb.s");
    
    // Run the simulation
    runSimulation(50000);
    
    // Check it matches with the result that you would get (see above)
    EXPECT_EQ((int)top->a0, 134);
}
```

When you run a test, it may or may not fail. It is recommended to use the
waveforms to debug (see above).


## Data analysis (analysis.py)

### Branch/Cache Hit-Rate

To perform data analysis, you need to "switch on comment blocks" in the RTL.
This can be a bit tedious, but this is necessary.

In `dm_cache.sv`:

```sv
// Analysis of cache - uncomment this block to get data
    // if (read_en && hit)           $display("HIT");
    // else if (read_en && ~hit)     $display("MISS");
    // else if (write_en)            $display("STORE");
```

In `pcnext_selector.sv`:

```sv
// // Analysis of branching - uncomment to get data
// if (branch && !(PCsrc == `PC_NEXT)) $display("BRANCH");
// else if (~branch && !(PCsrc == `PC_NEXT)) $display("NOT BRANCH");
```

Then, run the `doit.sh` script as following.

```
./doit.sh test/top-instr_tb.cpp > output.log
```

Now this can be fed in to be analysed by the Python script.

```bash
./analyse.py run --input output.log
```

Et voilà! This will give you branch and cache hit rate graphs.

### PDF plotting

To get PDF graphs through the PDF testbench, run the following:

```bash
./analyse.py demo
```

The behind-the-scenes mechanism can also be accessed:

```bash
# Obtain the Gaussian data
cp data/gaussian.mem ../rtl/data.hex
./doit.sh test/top-pdf_tb.cpp > gaussian.log

# Plot the Gaussian
./analyse.py plot --input gaussian.log
```

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