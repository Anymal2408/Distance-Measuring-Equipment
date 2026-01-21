`timescale 1ns / 1ps

module receiver #(
    parameter WIDTH    = 12,
    parameter threshup = 12'd1100,
    parameter threshdo = 12'd1000
)(
    input  wire             clk,
    input  wire             resetn,
    input  wire             start,
    input  wire [WIDTH-1:0] in_data,

    output reg  [31:0]      p1,
    output reg              valid
);

    // FSM states
    localparam idle = 3'b000;
    localparam pk   = 3'b001;
    localparam wat  = 3'b010;
    localparam done = 3'b011;

    reg [2:0]  state;
    reg [WIDTH-1:0] peak;
    reg [31:0] timer;
    reg [31:0] p [0:3];   // store 4 peak timers
    integer i;
    integer count;
    reg v;


    always @(posedge clk) begin
        if (!resetn) begin
            state  <= idle;
            peak   <= threshup;
            timer  <= 0;
            p1     <= 0;
            valid  <= 0;
            i      <= 0;
            count  <= 0;

            p[0] <= 0;
            p[1] <= 0;
            p[2] <= 0;
            p[3] <= 0;
        end 
        else begin
            
            // timer logic
            if (start && timer < 32'hFFFFFFFF)
                timer <= timer + 1;
            else
                timer <= 0;

           // valid <= 0; // default

            case (state)

                // -----------------------------
                idle:
                begin
                if (v)  begin
                  timer <= 0;
                  v<= 0;
                  end
                else if (in_data > threshup) begin
                   state <= pk;
                   peak  <= in_data;
                  end
                end

                // -----------------------------
                pk:
                begin
                valid <= 0;
                    if (in_data > peak) begin
                        peak <= in_data;
                        p[i] <= timer;          // store timer
                    end
                    else if (in_data < threshdo) begin
                        if (count == 3)          // 4th peak reached
                            state <= done;
                        else begin
                            count <= count + 1;
                            state <= wat;
                        end
                    end
                end

                // -----------------------------
                wat:
                begin
                    if (in_data > threshup) begin
                        i    <= i + 1;
                        peak <= threshup;
                        state <= pk;
                    end
                end

                // -----------------------------
                done:
                begin
                    valid <= 1;
                    v<= 1;
                    p1 <= p[0];  

                    // reset counters
                    i     <= 0;
                    count <= 0;
                    peak  <= threshup;

                    state <= idle;
                end

            endcase
        end
    end
endmodule
