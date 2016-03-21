module ControlUnit(Opcode,RegWrite,MemRead,MemWrite,
    branch,RegDst,ALUsrc,MemtoReg,ALUOp, jump);
    input [5:0]Opcode;
    output reg [1:0] ALUOp;
    output reg RegWrite, MemWrite, MemRead, branch,RegDst,ALUsrc,MemtoReg, jump ;
    always @(Opcode)
        if(Opcode==0) begin
            branch <=1'b0;
            RegDst <=1'b1;
            ALUsrc <=1'b0;
            MemtoReg <=1'b0;
            RegWrite <=1'b1;
            MemRead <=1'b0;
            MemWrite <=1'b0;
            ALUOp <= 2'b10;
        end
        else if (Opcode==35) // LOAD
        begin
            branch <=1'b0;
            RegDst <=1'b0;
            ALUsrc <=1'b1;
            MemtoReg <=1'b1;
            RegWrite <=1'b1;
            MemRead <=1'b1;
            MemWrite <=1'b0;
            ALUOp <=2'b00; // add
            jump <=1'b0;
        end
        else if (Opcode==43) //STORE
        begin
            branch <=1'b0;
            RegDst <=1'bz;
            ALUsrc <=1'b1;
            MemtoReg <=1'bz;
            RegWrite <=1'b0;
            MemRead <=1'b0;
            MemWrite <=1'b1;
            ALUOp <=2'b00; // add
            jump <=0;
        end
        else if (Opcode==4) // BEQ
        begin
            branch <=1'b1;
            RegDst <=1'bz;
            ALUsrc <=1'b0;
            MemtoReg <=1'bz;
            RegWrite <=1'b0;
            MemRead <=1'b0;
            MemWrite <=1'b0;
            ALUOp <=2'b01; //sub
            jump <=1'b0;
        end
        else if (Opcode==8) //Addi
        begin
            branch <=1'b0;
            RegDst <=1'b0;
            ALUsrc <=1'b1;
            MemtoReg <=1'b0;
            RegWrite <=1'b1;
            MemRead <=1'b0;
            MemWrite <=1'b0;
            ALUOp <=2'b0010; // add
            jump <=1'b0;
        end
        else if (Opcode==2) //JUMP
        begin
            branch <=1'b0;
            RegDst <=1'bz;
            ALUsrc <=1'bz;
            MemtoReg <=1'bz;
            RegWrite <=1'b0;
            MemRead <=1'b0;
            MemWrite <=1'b0;
            ALUOp <=2'bzz;
            jump <=1'b1;
        end
        endmodule
