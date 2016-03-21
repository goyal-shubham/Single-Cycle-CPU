module PC(reset , clk, PcIn, PcOut);
input clk , reset;
input [31:0] PcIn;
output reg [31:0] PcOut;
always @ (negedge clk) begin
    if(reset) PcOut <= 0;
        else PcOut <= PcIn + 1;
        end
    endmodule
