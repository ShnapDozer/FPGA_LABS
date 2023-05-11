`timescale 1ns / 1ps

module riscv_core(
    input clk_i,
    input rst_i,

    input   [31:0] instr_i,
    input   [31:0] RD_i,

    output  WE_o,
    output  [31:0] WD_o,
    output  [31:0] instr_addr_o,
    output  [31:0] data_addr_o,
    output  [2:0] size_o
);     
    wire [1:0]   srcA;      
    wire [2:0]   srcB;       
    wire [4:0]   alu_op;       
    wire         mem_req;            
    wire         mem_we;            
    wire [2:0]   mem_size;           
    wire         gpr_we_a;           
    wire         wb_src_sel;         
    wire         illegal_instr;     
    wire         branch;      
    wire         jal;             
    wire         jalr;  

    decoder_riscv decoder (
        .fetched_instr_i  (instr_i),

        .ex_op_a_sel_o    (srcA),
        .ex_op_b_sel_o    (srcB),
        .alu_op_o         (alu_op),
        .mem_req_o        (mem_req),
        .mem_we_o         (mem_we),
        .mem_size_o       (mem_size),
        .gpr_we_a_o       (gpr_we_a),
        .wb_src_sel_o     (wb_src_sel),
        .illegal_instr_o  (illegal_instr),
        .branch_o         (branch),
        .jal_o            (jal),
        .jalr_o           (jalr)
    );

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    reg [31:0] WriteData;

    assign WD_o = ReadData2; 

    rf_riscv reg_file(
        .clk(clk_i),
        .WE(gpr_we_a),
        
        .A1(instr_i[19:15]),
        .A2(instr_i[24:20]),
        .A3(instr_i[11:7]),
        
        .WD3(WriteData),
        .RD1(ReadData1),
        .RD2(ReadData2)
    );

    wire PC_o;

    wire [31:0] se_imm_I = {{20{instr_i[31]}}, instr_i[31:20]};
    wire [31:0] se_imm_U = {instr_i[31:12], {12{1'b0}}};
    wire [31:0] se_imm_S = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
    wire [31:0] se_imm_J = {{10{instr_i[31]}}, instr_i[31], instr_i[19:12], instr_i[20], instr_i[31:21]};
    wire [31:0] se_imm_B = {{19{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};

    reg [31:0] alu_A;
    reg [31:0] alu_B;

    reg [31:0] WriteData;
    
    always @(*) begin
           case(srcA) 
            0: alu_A <= ReadData1;
            1: alu_A <= PC_o;
            2: alu_A <= 0;
        endcase

        case(srcB) 
            0: alu_B <= ReadData2;
            1: alu_B <= se_imm_I;
            2: alu_B <= se_imm_U;
            3: alu_B <= se_imm_S;
            4: alu_B <= 4;
        endcase

        case(wb_src_sel) 
            0: WriteData <= aluResult;
            1: WriteData <= RD_i;
        endcase
    end

    
    wire [31:0] aluResult;

    assign data_addr_o = aluResult;

    alu_riscv alu(
        .A(alu_A),
        .B(alu_B),
        .ALUOp(alu_op),
        
        .Flag(comp),
        .Result(aluResult)
    );



    wire comp;
    wire [31:0] branchAddr;
    wire [31:0] immAddr;

    reg [31:0] branchImm;
    reg [31:0] branchOut;
    reg [31:0] nextAddr;

    wire jumpComp = (comp & branch) | jal;

    always @(*) begin

        // Выбор констант
        case(branch)
            0: branchImm <= se_imm_J;
            1: branchImm <= se_imm_B;
        endcase

        case(jumpComp)
            0: branchOut <= 4;
            1: branchOut <= branchImm;
        endcase

        case(jalr)
            0: nextAddr <= branchAddr;
            1: nextAddr <= immAddr;
        endcase

    end

    fulladder32 branchAddr_adder(
        .A(instr_addr_o),  
        .B(branchOut),
        .Pin(1'b0),
        .S(branchAddr) 
    );

    fulladder32 immAddr_adder(
        .A(ReadData1),  
        .B(se_imm_I),
        .Pin(1'b0),
        .S(immAddr) 
    );
        
    PC pc(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .d_i(nextAddr),
        .addr_o(instr_addr_o)
    );
        


endmodule
