module instr_mem(
        input [31:0] addr,
        output[31:0] read_data
    );
    
    reg [7:0] RAM [0:1023];
    initial $readmemb("program.txt", RAM);
    
    assign read_data = {
        RAM[addr + 3], 
        RAM[addr + 2],
        RAM[addr + 1],
        RAM[addr]
    };
endmodule
