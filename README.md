Team 24
- James Mitchell
- Kevin Lau (repo master)
- Noam Wietzman
- William Huynh

Team contribution:
- https://docs.google.com/spreadsheets/d/1qkn8uNHzbcW35JPvH5nXA2zehHfRK2pVViz1fDL2NVE/edit?usp=sharing

### Installing Dependencies

```bash
sudo apt update
sudo apt install -y libgtest-dev lcov verilator gcc-riscv64-unknown-elf
sudo apt install -y make g++ git autoconf python3 flex bison

echo "Installing Verilator"
cd /tmp
rm -rf verilator

# Verilator must be at least v4.226
git clone https://github.com/verilator/verilator verilator
cd verilator
git checkout v4.226
autoconf
./configure
make -j "$(nproc)"
sudo make install
cd ..
rm -rf verilator
```

### Running the testbenches

```bash
cd tb
./doit.sh
```
