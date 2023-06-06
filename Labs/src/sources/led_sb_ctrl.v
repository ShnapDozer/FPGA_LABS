module led_sb_ctrl(
/*
    Часть интерфейса модуля, отвечающая за подключение к системной шине
*/
  input         clk_i,
  input [31:0]  addr_i,
  input         req_i,
  input [31:0]  WD_i,
  input         WE_i,
  output reg [31:0] RD_o,

/*
    Часть интерфейса модуля, отвечающая за подключение к периферии
*/
  output [15:0]  led_o
);

    reg [15:0]  led_val;
    reg         led_mode;
      
    reg [31:0] counter;
    reg enable;
    
    always @(posedge clk_i) begin
        if(counter > 10_000_000) begin
            enable <= ~enable;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
    
    assign led_o = led_mode ? (enable ? led_val : 0) : led_val;
    
    
    
    always @(posedge clk_i) begin
        case(addr_i) 
            32'h0: begin
                RD_o <= led_val;
                
                if(WE_i & (WD_i <= 65535)) begin
                    led_val <= WD_i[15:0];
                end
            end
            32'h4: begin
                RD_o <= led_mode;
                
                if(WE_i & (WD_i <= 1'b1)) begin
                    led_mode <= WD_i[0];
                end
            end
            32'h24: begin
                RD_o <= 0;
                
                if(WD_i == 1) begin 
                    led_val <= 0;
                    led_mode <= 0;
                    enable <= 0;
                    counter <= 0;
                end
            end
            default: begin
                end
        endcase
    end
        
endmodule