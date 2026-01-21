module moving_average #(
    parameter WIDTH = 24,
    parameter N = 128 //give power of 2 preferably because i have directly used clog2
)(
    input  wire clk,
    input  wire resetn,
    input  wire [WIDTH-1:0] in,
    output reg  [WIDTH-1:0] out
);

    localparam SUM_WIDTH = WIDTH + $clog2(N);

    reg [WIDTH-1:0] buffer [0:N-1];
    reg [$clog2(N)-1:0] idx;               
    reg [SUM_WIDTH-1:0] sum;
    reg [$clog2(N):0] fill_count; 
    integer k;
    reg [WIDTH-1:0] out1;
    
    always @(posedge clk) begin
        if (!resetn) begin
            for (k = 0; k < N; k = k+1)
                buffer[k] <= 0;

            idx        <= 0;
            sum        <= 0;
            out        <= 0;
            fill_count <= 0;
        end
        else begin
            out1 = in[WIDTH-1] ? (~in + 1'b1) : in;
            if (fill_count < N) begin
                buffer[fill_count] <= out1;
                sum <= sum + out1;
                fill_count <= fill_count + 1;

                if (fill_count == N-1)
                    out <= sum >> $clog2(N);  
            end
            else begin
                sum <= sum - buffer[idx] + out1;
                buffer[idx] <= out1;
                idx <= (idx == N-1) ? 0 : idx + 1;
                out <= sum >> $clog2(N);
            end
        end
    end

endmodule
