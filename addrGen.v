`timescale 1ns / 1ps
module addrGen #(parameter memDepth=1000,addrWidth=$clog2(memDepth))(
input                     clk,
input ena,
input resetn,
output reg [addrWidth-1:0] addr );

always @(posedge clk)
begin
if(!resetn)begin
addr <= 0;
end
else begin
if(ena)begin
    if(addr != memDepth-1)
        addr <= addr+1;
    else
        addr <= 0;
end
end
end
endmodule