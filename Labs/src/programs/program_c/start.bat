gcc/bin/riscv-none-elf-g++ -c -march=rv32i -mabi=ilp32 startup.S -o startup.o
gcc/bin/riscv-none-elf-g++ -c -march=rv32i -mabi=ilp32 main.cpp -o main.o
gcc/bin/riscv-none-elf-g++ -march=rv32i -mabi=ilp32 -Wl,--gc-sections -nostartfiles -T linker_script.ld startup.o main.o -o result.elf
gcc/bin/riscv-none-elf-objcopy -O verilog result.elf init.mem

gcc/bin/riscv-none-elf-objcopy -O verilog -j .text result.elf init_instr.mem
gcc/bin/riscv-none-elf-objcopy -O verilog -j .data -j .bss result.elf init_data.mem