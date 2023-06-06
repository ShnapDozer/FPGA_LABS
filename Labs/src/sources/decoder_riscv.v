`include "defines_riscv.v"

module decoder_riscv (
  input       [31:0]  fetched_instr_i,      // ??????????
  output  reg [1:0]   ex_op_a_sel_o,        // ??????????? ?????? ?????????????? ??? ?????? ??????? ???????? ???
  output  reg [2:0]   ex_op_b_sel_o,        // ??????????? ?????? ?????????????? ??? ?????? ??????? ???????? ???
  output  reg [4:0]   alu_op_o,             // ???????? ???
  output  reg         mem_req_o,            // ?????????? ? ?????? ? ??????? ??? ????????
  output  reg         mem_we_o,             // 1, ???? ?????????? ???????? ?????? ? ??????, ? 0 ? ???? ??????? ?? ??????
  output  reg [2:0]   mem_size_o,           // ??????????? ?????? ?????? ?????? ??????????? ??? ????????
  output  reg         gpr_we_a_o,           // ????? ?? ???????? ?????? ? ??????????? ????
  output  reg         wb_src_sel_o,         // ??????????? ?????? ?????????????? ??? ?????? ??????, ???????????? ? ??????????? ????
  output  reg         illegal_instr_o,      // ?????? ? ???????????? ?????????? 
  output  reg         branch_o,             // ?????? ?? ?????????? ????????? ????????
  output  reg         jal_o,                // ?????? ?? ?????????? ???????????? ???????? jal
  output  reg         jalr_o               
);

    wire [1:0]opcode_d = fetched_instr_i[1:0];
    wire [4:0]opcode = fetched_instr_i[6:2];
    wire [2:0]func3 = fetched_instr_i[14:12];
    wire [6:0]func7 = fetched_instr_i[31:25];
 
    always @(*) begin
        illegal_instr_o = 0;
        
        ex_op_a_sel_o = 0;
        ex_op_b_sel_o = 0;
        alu_op_o = 0;
        
        mem_size_o = 0;
        mem_req_o = 0;
        mem_we_o = 0;
        gpr_we_a_o = 0;
        
        wb_src_sel_o = 0;
        
        branch_o = 0;
        jal_o = 0;
        jalr_o = 0;

        if(opcode_d != 2'b11)
            illegal_instr_o = 1;
        else begin
            case(opcode) // opcode 

            5'b01100:begin // alu operation

                if ((func7 == 7'h00) | ((func7 == 7'h20) & 
                    ((func3 == 3'b000) | (func3 == 3'b101)))) begin
                       
                    ex_op_a_sel_o = 0;
                    ex_op_b_sel_o = 0;
                    
                    alu_op_o = {func7[6:5], func3};
                    
                    wb_src_sel_o = 0;
                    gpr_we_a_o = 1;
                    
                end else begin 
                    illegal_instr_o = 1;
                end
            end

            5'b00100:begin // OP_IMM 

                if ( ((func3 == 3'h1) & (func7 != 7'h00)) | 
                    ((func3 == 3'h5) & (func7 != 7'h00) & (func7 != 7'h20)) ) begin
                        illegal_instr_o = 1;

                end else begin
                    ex_op_a_sel_o = 0;
                    ex_op_b_sel_o = 1;
                    
                    if(func3 == 1'h5) begin 
                        alu_op_o = {func7[6:5], func3};
                    end else begin 
                        alu_op_o = {2'b00, func3};
                    end
                    wb_src_sel_o = 0;
                    gpr_we_a_o = 1;

                end
            end

            5'b00000:begin // LOAD

                if((func3 <= 3'h5) & (func3 != 3'h3)) begin 
                    ex_op_a_sel_o = 0;
                    ex_op_b_sel_o = 1;
                    
                    alu_op_o = `ALU_ADD;
                    
                    mem_req_o = 1;
                    mem_size_o = func3;
                    
                    wb_src_sel_o = 1;
                    gpr_we_a_o = 1;

                end else begin 
                    illegal_instr_o = 1;
                end                

            end

            5'b01000:begin // STORE

                if(func3 <= 3'h2) begin 
                    ex_op_a_sel_o = 0;
                    ex_op_b_sel_o = 3;
                    
                    alu_op_o = `ALU_ADD;

                    mem_req_o = 1;
                    mem_we_o = 1;
                    mem_size_o = func3;

                end else begin 
                    illegal_instr_o = 1;
                end    
            end

            5'b11000:begin // BRANCH
                if((func3 != 3'h2) & (func3 != 3'h3)) begin                
                    branch_o = 1;
                    
                    ex_op_a_sel_o = 0;
                    ex_op_b_sel_o = 0;
                    
                    alu_op_o = {2'b11, func3};

                end else begin 
                    illegal_instr_o = 1;
                end
            end

            5'b11011:begin // JAL
                jal_o = 1;
            
                ex_op_a_sel_o = 1;
                ex_op_b_sel_o = 4;
                
                alu_op_o = `ALU_ADD;
                
                wb_src_sel_o = 0;
                gpr_we_a_o = 1;            
            end

            5'b11001:begin // JALR
                if(func3 == 3'h0) begin
                jalr_o = 1;
            
                ex_op_a_sel_o = 1;
                ex_op_b_sel_o = 4;
                
                alu_op_o = `ALU_ADD;
                
                wb_src_sel_o = 0;
                gpr_we_a_o = 1; 

                end else begin 
                    illegal_instr_o = 1;
                end
            
            end

            5'b01101:begin // LUI
                ex_op_a_sel_o = 2;
                ex_op_b_sel_o = 2;
                
                alu_op_o = `ALU_ADD;
                
                wb_src_sel_o = 0;
                gpr_we_a_o = 1;
            end 

            5'b00101:begin // AUIPC
                ex_op_a_sel_o = 1;
                ex_op_b_sel_o = 2;
                
                alu_op_o = `ALU_ADD;
                
                wb_src_sel_o = 0;
                gpr_we_a_o = 1;
            end

            5'b00011:begin // MISC-MEM
                if(func3 != 0) begin
                    illegal_instr_o = 1;
                end else begin
                end
            end

            5'b11100: begin // SYSTEM
                if(!((fetched_instr_i[31:7] == 0) | 
                ((fetched_instr_i[31:20] == 1) & (fetched_instr_i[19:7] == 0)))) begin
                    illegal_instr_o = 1;
                end else begin 
                end
            end

            default: begin
                illegal_instr_o = 1;

                ex_op_a_sel_o = 0;
                ex_op_b_sel_o = 0;

                alu_op_o = 0;
                
                mem_req_o = 0;
                mem_we_o = 0;
                gpr_we_a_o = 0;
                
                wb_src_sel_o = 0;
                
                branch_o = 0;
                jal_o = 0;
                jalr_o = 0;

                mem_size_o = 0;
            end
            
            endcase
        end       
    end

endmodule