module FullAdder ( PcAdd4 , shiftOut, ALUOut);
input [31:0] PcAdd4;
input [31:0] shiftOut;
output reg [31:0] ALUOut;
always @ (PcAdd4 or ALUOut ) begin
    ALUOut = PcAdd4 + shiftOut;
end
endmodule
