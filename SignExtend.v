module SignExtend(SignInputData , SignOutputData);
input [15:0] SignInputData;
output [31:0] SignOutputData;
reg [31:0] SignOutputData;
always @ ( SignInputData)
begin
    SignOutputData[15:0] <= SignInputData[15:0];
    SignOutputData[31:16] <= {16{SignInputData[15]}};
end
endmodule
