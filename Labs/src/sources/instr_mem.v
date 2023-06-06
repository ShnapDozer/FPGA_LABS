module instr_mem(
        input [31:0] addr,
        output[31:0] read_data
    );
    
    reg [7:0] RAM [0:1023];
<<<<<<< HEAD:Labs/src/sources/instr_mem.v
    initial $readmemh("init_program.txt", RAM);
=======
    initial $readmemh("program.txt", RAM);
>>>>>>> 806d6b0dcd0b35eb824cfe24ba72fb6e9f142a05:labs.srcs/sources_1/new/instr_mem.v
    
    assign read_data = {
        RAM[addr + 3], 
        RAM[addr + 2],
        RAM[addr + 1],
        RAM[addr]
    };
endmodule
