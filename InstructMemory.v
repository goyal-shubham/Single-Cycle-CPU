module InstructMemory (clk, InstructAddress , InstructOutput);
input [31:0] InstructAddress;
input clk;
output reg[31:0] InstructOutput;
reg[31:0] IM[1023:0];
initial begin
    IM[0] = 32'h00221820; // add
    IM[1] = 32'hAC010000; // sw
    IM[2] = 32'h8c240000; // ld
    IM[3] = 32'h10210001; //beq
    IM[4] = 32'h00001820;
    IM[5] = 32'h00411822; //sub
end
always @(posedge clk) begin
    InstructOutput <= IM[InstructAddress];
end
endmodule

