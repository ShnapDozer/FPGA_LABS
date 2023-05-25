module OneHotEncoder(
    input [7:0] addres_in,
    output reg [255:0] select_out
);
    always@(*) begin
        select_out <= 1'b0 | 1'b1 << addres_in;
    end
//    genvar i;
//    generate 
//        for(i=0; i<255; i = i+1 ) begin
//            always@(*) begin
                
                
//                if(i == addres_in) begin
//                    select_out[i] <= 1'b1;
//                end else begin
//                    select_out[i] <= 1'b0;
//                end
//            end
//        end
//    endgenerate
    
    
    
endmodule