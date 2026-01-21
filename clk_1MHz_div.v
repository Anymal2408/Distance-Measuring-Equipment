`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2025 16:20:25
// Design Name: 
// Module Name: clk_1MHz_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_1MHz_div(
input clk,
output reg clk_1MHz

    );
    localparam DIV_COUNT = 50;
    reg [6:0] counter = 0;

    always @(posedge clk) begin
        if (counter == DIV_COUNT-1) begin
            counter   <= 0;
            clk_1MHz  <= ~clk_1MHz;   // toggle output ? gives divide-by-100
        end
        else begin
            counter <= counter + 1;
        end
    end
endmodule
