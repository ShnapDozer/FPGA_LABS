module rf_riscv(
        input           clk,
        input           WE,
        
        input [4:0]    A1,
        input [4:0]    A2,
        input [4:0]    A3,
        
        input   [31:0]    WD3,
        output  [31:0]    RD1,
        output  [31:0]    RD2
    );
    
    initial begin 
         REGS[0] = 32'b0;
    end
    
    reg [31:0] REGS [0:31];
    
    assign RD1 = A1 == 5'b0 ? 32'b0 : REGS[A1];
    assign RD2 = A2 == 5'b0 ? 32'b0 : REGS[A2];
   
    always @ (posedge clk) begin
        if (WE && (A3 != 5'b0)) begin
            REGS[A3] <= WD3;
        end
    end 
endmodule