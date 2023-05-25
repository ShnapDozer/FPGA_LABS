module sw_sb_ctrl(
/*
    Часть интерфейса модуля, отвечающая за подключение к системной шине
*/
  input [31:0]  addr_i,
  input         req_i,
  input [31:0]  WD_i, // \
  input         clk_i,//  - эти сигналы не используются и добавлены для совместимости с системной шиной
  input         WE_i, // /
  output reg [31:0] RD_o,

/*
    Часть интерфейса модуля, отвечающая за подключение к периферии
*/
  input [15:0]  sw_i
);

    always@(posedge clk_i) begin
        case(addr_i)
            32'h0:
                RD_o <= {{16{1'b0}}, sw_i};
            default:
                RD_o <= 0;
        endcase
    end



endmodule