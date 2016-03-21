module MIPSReg (Read1, Read2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
input [4:0] Read1, Read2, WriteReg;
input [31:0] WriteData;
input RegWrite, clock;
output [31:0] Data1, Data2;
reg [31:0] RF [31:0];
initial begin
    RF[0] = 10;
    RF[1] = 20;
    RF[2] = 30;
    RF[3] = 40;
    RF[5] = 50;
end
assign Data1 = RF[Read1];
assign Data2 = RF[Read2];
always begin
    @(negedge clock) if (RegWrite) RF[WriteReg] <= WriteData;
    end
endmodule
