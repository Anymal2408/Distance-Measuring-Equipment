`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module transmitter (
    input  wire clk,
    input  wire resetn,
    input wire [11:0] sqcos,
    //input  wire start,
    output wire enable,
    output wire [11:0] sig_to_dac,
    input [31:0] T1, T2, T3
);

    localparam DIV_COUNT = 50;
    reg clk_1MHz;
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
    wire ena;
    wire [23:0] of_signal;
    assign sig_to_dac = $signed(of_signal) >>> 11;
    assign enable = ena;

    signalGen geb(.clk(clk_1MHz),.ena(ena),.resetn(resetn),.out2(of_signal), .T1(T1), .T2(T2), .T3(T3),.sqcos(sqcos));

endmodule
