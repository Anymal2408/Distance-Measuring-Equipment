`timescale 1ns / 1ps
module signalGen(
input clk,resetn,
input [31:0] T1, T2, T3,
output wire ena,
input [11:0] sqcos,
output reg signed [23:0] out2 //enevlope goes to receiver
    );
   
   
    wire [12:0] addr1;
    wire [11:0] sin;
    reg [23:0] o_signal;
    //wire ena;   
   
    always @(posedge clk)
    begin
   // if(ena) begin
    out2 <= $signed(sqcos) * $signed(sin);
//    end
//    else out2 <= 0;
//   
    end
   
//    moving_average #(
//    .WIDTH(24),          
//    .N(128)                // number of samples in average calculate fs/fc and put more than that
//)movavg(
//    .clk(clk),
//    .resetn(resetn),
//    .in(abs),
//    .out(env)    
//);
   
   enControl en_ctrl (
       .clk(clk), 
       .T1(T1),
       .T2(T2),
       .T3(T3),
       .resetn(resetn),
       .en(ena)
    );
   
    addrGen #(.memDepth(5000))addGen(
    .clk(clk),
    .ena(ena),
    .resetn(resetn),
    .addr(addr1)
    );
   
    blk_mem_gen_0 w (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addr1),  // input wire [12 : 0] addra
  .douta(sin)  // output wire [11 : 0] douta
);

   
endmodule