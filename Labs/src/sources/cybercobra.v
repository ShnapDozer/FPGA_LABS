module CYBERcobra(
    input           clk_i,
    input           rst_i,
    input   [15:0]  sw_i,
    output  [31:0]  out_o
);

    reg  [31:0] branchChoice;
    wire [31:0] addr;
    wire [31:0] nextAddr;
    wire [31:0] readData;
       
    fulladder32 adder(
      .A(addr),  
      .B(branchChoice),
      .Pin(1'b0),
      .S(nextAddr) 
    );
    
    PC pc(
        .clk_i(clk_i),
        .rst_i(~rst_i),
        .d_i(nextAddr),
        .addr_o(addr)
    );
    
    instr_mem instr(
        .addr(addr),
        .read_data(readData)
    );
    
    
    wire    WE, branch;
    
    reg  [31:0] WD3;
    wire [31:0] aluResult, RD1, RD2;
    wire [31:0] constant;    
    
    assign sw_i_se = {{16{1'b0}}, sw_i};
    assign constant = {{9{1'b0}}, readData[27:5]};
    assign branchAddr_se = {{22{1'b0}}, readData[12:5], {2{1'b0}}};
    
    assign out_o = RD1;
            
    always@(*) begin
        if((branch && readData[30]) || readData[31]) branchChoice <= branchAddr_se;
        else branchChoice <= 32'd4;
    end
    
    always@(*) begin
        case(readData[29:28])
            2'b00: WD3 <= constant;
            2'b01: WD3 <= aluResult;
            2'b10: WD3 <= sw_i_se;
            2'b11: WD3 <= 32'd0;
        endcase
    end
    
    alu_riscv alu(
        .A(RD1),
        .B(RD2),
        .ALUOp(readData[27:23]),
        
        .Flag(branch),
        .Result(aluResult)
    );
    
    rf_riscv regFile(
        .clk(clk_i),
        .WE(~(readData[30] || readData[31])),
        
        .A1(readData[22:18]),
        .A2(readData[17:13]),
        .A3(readData[4:0]),
        
        .RD1(RD1),
        .RD2(RD2),
        .WD3(WD3)

    );   
endmodule
