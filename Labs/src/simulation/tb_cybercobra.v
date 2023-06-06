`timescale 1ns / 1ps

module tb_CYBERcobra();
    
        wire [31:0] OUT;
    reg clk;
    reg rstn;
    reg [15:0] INr;
    
    CYBERcobra dut(
    .clk_i(clk),
    .rst_i(rstn),
    .sw_i (INr ),
    .out_o(OUT)
    );
    


    initial clk <= 0;
    always #5 clk = ~clk;
    
    initial begin 
    INr = 15'b000001000;
    rstn = 1'b0;

    #10;
    rstn = 1'b1;


    #20000;
    $stop;
    end
    
endmodule