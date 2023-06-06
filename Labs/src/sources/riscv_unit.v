module riscv_unit(
    input clk_i,
    input rst_i
);

    wire [31:0] read_instr;
    wire [31:0] instr_addr;

    wire [31:0] read_data;
    wire [31:0] write_data;
    wire [31:0] write_data_addr;
    wire WE;
    
    
    wire [255:0] periphWire;
    OneHotEncoder periphEncoder(
        .addres_in(write_data_addr[31:24]),
        .select_out(periphWire)
    );
    
    sw_sb_ctrl (
        .clk_i(clk_i),
        .addr_i(),
        .req_i(),
        .WD_i(),
        .WE_i(),
        .RD_o(),
        .led_o()
    );
    
    led_sb_ctrl (
        .clk_i(clk_i),
        .addr_i(),
        .req_i(),
        .WD_i(write_data),
        .WE_i(WE),
        .RD_o(),
        .led_o()
    );

    riscv_core core(
        .clk_i(clk_i),
        .rst_i(rst_i),

        .instr_i(read_instr),
        .RD_i(read_data),

        .WE_o(WE),
        .WD_o(write_data),
        .instr_addr_o(instr_addr),
        .data_addr_o(write_data_addr)
    );

    instr_mem instrMem(
        .addr(instr_addr),
        .read_data(read_instr)
    );

    data_mem dataMem(
        .clk(clk_i),
        .WE(WE),
        .addr(write_data_addr),
        .write_data(write_data),
        .read_data(read_data)
    );

endmodule