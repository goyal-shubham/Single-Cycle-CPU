module DataMemory (Address, WriteData, ReadData, MemRead , MemWrite, Clock);
input [31:0] WriteData, Address;
input MemRead, MemWrite, Clock;
output reg [31:0] ReadData;
reg [31:0] DM [255:0];
always @(posedge Clock) begin
    if(MemRead) ReadData = DM[Address];
    end
always @(negedge Clock) begin
    if(MemWrite && !MemRead) DM[Address] = WriteData;
    end
initial begin
    DM[10] = 4;
    DM[20] = 5;
    DM[30] = 8;
    DM[40] = 10;
    DM[50] = 15;
end
endmodule
