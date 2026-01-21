`timescale 1ns / 1ps
module receiver_top(
input clk,
input resetn,
input start, 
input [11:0] adc_signal,
output reg [31:0] p1,
output valid
    );
    
    localparam DIV_COUNT = 50;
    reg [6:0] counter = 0;
    reg clk_1MHz;

    always @(posedge clk) begin
        if (counter == DIV_COUNT-1) begin
            counter   <= 0;
            clk_1MHz  <= ~clk_1MHz;   // toggle output ? gives divide-by-100
        end
        else begin
            counter <= counter + 1;
        end
    end
    
    wire [31:0] p1_wire;
    wire [11:0] env;
    
       moving_average #(
        .WIDTH(24),
        .N(128) //give power of 2 preferably because i have directly used clog2
        )movAvg(
        .clk(clk_1MHz),
        .resetn(resetn),
        .in(adc_signal),
        .out(env)
        );
    
        receiver rec (
        .clk(clk_1MHz),
        .resetn(resetn),
        .start(start),
        .in_data(env),
        .p1(p1_wire),
        .valid(valid)
    );

    always@(posedge clk_1MHz)
     p1 <= p1_wire;   // expose p1 to top output
endmodule
