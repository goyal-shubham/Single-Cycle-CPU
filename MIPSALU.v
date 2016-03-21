module MIPSALU (ALUctl, ALU_A, ALU_B, ALUOut, Zero);
input [3 :0] ALUctl;
input [31:0] ALU_A, ALU_B;
output reg [31:0] ALUOut;
output Zero;
assign Zero = (ALUOut==0);
always @(ALUctl, ALU_A, ALU_B)
    case (ALUctl)
        0: ALUOut <= ALU_A & ALU_B;
        1: ALUOut <= ALU_A | ALU_B;
        2: ALUOut <= ALU_A + ALU_B;
        6: ALUOut <= ALU_A ALU_
        B;
        7: ALUOut <= ALU_A < ALU_B ? 1:0;
        12: ALUOut <= ~(ALU_A | ALU_B);
        default: ALUOut <=0;
    endcase
    endmodule
