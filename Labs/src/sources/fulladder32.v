module fulladder(
  input      a,  
  input      b,
  input     Pin,

  output     S,    
  output     Pout
  );
    
      assign Pout = ((a & b) | (a & Pin)) | (b & Pin);
      assign S =  (a ^ b) ^ Pin;

  endmodule
  
    
module fulladder4(
  input [3:0]   a,  
  input [3:0]   b,
  input         Pin,
  
  output [3:0]  S,    
  output        Pout
  );
 
    wire [2:0] P;
    fulladder a0 (
        .a(a[0]),
        .b(b[0]),
        .Pin(Pin),
        .S(S[0]),
        .Pout(P[0])
    );
        fulladder a1 (
        .a(a[1]),
        .b(b[1]),
        .Pin(P[0]),
        .S(S[1]),
        .Pout(P[1])
    );
        fulladder a2 (
        .a(a[2]),
        .b(b[2]),
        .Pin(P[1]),
        .S(S[2]),
        .Pout(P[2])
    );
    
        fulladder a3 (
        .a(a[3]),
        .b(b[3]),
        .Pin(P[2]),
        .S(S[3]),
        .Pout(Pout)
    );


  endmodule
  
module fulladder16(
    input [15:0]   a,  
    input [15:0]   b,
    input         Pin,
    
    output [15:0]  S,    
    output        Pout
);
     
        wire [2:0] P;
        fulladder4 a0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .Pin(Pin),
        .S(S[3:0]),
        .Pout(P[0])
    );
        fulladder4 a1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .Pin(P[0]),
        .S(S[7:4]),
        .Pout(P[1])
    );
        fulladder4 a2 (
        .a(a[11:8]),
        .b(b[11:8]),
        .Pin(P[1]),
        .S(S[11:8]),
        .Pout(P[2])
    );
        fulladder4 a3 (
        .a(a[15:12]),
        .b(b[15:12]),
        .Pin(P[2]),
        .S(S[15:12]),
        .Pout(Pout)
    );


  endmodule
    
  module fulladder32(
      input [31:0]  A,  
      input [31:0]  B,
      input         Pin,
      
      output [31:0] S,    
      output        Pout
  );
  
    wire P;
    fulladder16 a0 (
        .a(A[15:0]),
        .b(B[15:0]),
        .Pin(Pin),
        .S(S[15:0]),
        .Pout(P)
    );
        fulladder16 a1 (
        .a(A[31:16]),
        .b(B[31:16]),
        .Pin(P),
        .S(S[31:16]),
        .Pout(Pout)
    );
  
  endmodule
