module enControl
(
    input  wire clk,
    input  wire resetn,
    input [31:0] T1, T2, T3,
    output reg  en
);
    localparam S_ON1  = 2'd0;
    localparam S_OFF2 = 2'd1;
    localparam S_ON1B = 2'd2;
    localparam S_OFF3 = 2'd3;

    reg [1:0] state;
    reg [31:0] counter;

    always @(posedge clk) begin
        if (!resetn) begin
            state   <= S_ON1;
            counter <= 0;
            en      <= 1'b0;
        end
        else begin
            counter <= counter + 1;

            case (state)
                S_ON1: begin
                    en <= 1'b1;
                    if (counter == T1-1) begin
                        state   <= S_OFF2;
                        counter <= 0;
                    end
                end

                S_OFF2: begin
                    en <= 1'b0;
                    if (counter == T2-1) begin
                        state   <= S_ON1B;
                        counter <= 0;
                    end
                end

               
                S_ON1B: begin
                    en <= 1'b1;
                    if (counter == T1-1) begin
                        state   <= S_OFF3;
                        counter <= 0;
                    end
                end

                S_OFF3: begin
                    en <= 1'b0;
                    if (counter == T3-1) begin
                        state   <= S_ON1;
                        counter <= 0;
                    end
                end

            endcase
        end
    end
endmodule