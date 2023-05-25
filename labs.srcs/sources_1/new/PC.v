module PC (
    input               clk_i,
    input               rst_i,
    input       [31:0]  d_i,
    output  reg [31:0] addr_o
);

    always @(posedge clk_i) begin
        if(rst_i) addr_o <= 0;
        else addr_o <= d_i;
    end
    
endmodule