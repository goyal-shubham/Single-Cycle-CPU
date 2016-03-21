module MIPSCPU(reset, clk, INST, ALUOUT , MEMORYREAD, PCOUT, REGREAD1,
    REGDATA1 , REGREAD2, REGDATA2, REGWRITE , MEMWRITE , MEMREAD,
    WRITEADDREG, REGWRITEDATA, ALUIN, MEMWRITEDATA);
    input reset , clk;
    output [31:0] INST , ALUOUT , MEMORYREAD, PCOUT, REGDATA1 , REGREAD1,
        REGDATA2, REGREAD2, REGWRITEDATA, ALUIN, MEMWRITEDATA;
        output REGWRITE , MEMWRITE , MEMREAD;
        output [4:0] WRITEADDREG;
        wire [31:0] instruction , PcPlus1, RegData1 , RegData2 , SE_1_Out , ALUIn_2, ALUResult,
            ReadDataMem , Mux3_Out , ALUOut_PC, Mux2_Out ;
            wire [4:0] WriteRegAddr;
            wire [3:0] ALUControl;
            wire [1:0] ALUOpCode;
            wire RegDst1 , RegWrite1 , ALUsrc1 , MemWrite1 , MemRead1 , MemtoReg1 , branch1 , Zero1 ,
                AND_1_Out;
                PC pc_1 (.PcIn(Mux3_Out) , .reset(reset) , .clk(clk) , .PcOut(PcPlus1));
                InstructMemory IM_1 (.InstructAddress(PcPlus1) , .clk(clk), .InstructOutput(instruction));
                MUX5 MUX5_1 (.MuxB(instruction[20:16]) , .MuxA(instruction[15:11]) , .MuxSel(RegDst1) ,
                    .MuxOut(WriteRegAddr));
                    MUX MUX_1 (.MuxB(RegData2) , .MuxA(SE_1_Out) , .MuxSel(ALUsrc1) , .MuxOut(ALUIn_2));
                    MUX MUX_2 (.MuxB(ALUResult) , .MuxA(ReadDataMem) , .MuxSel(MemtoReg1) ,
                        .MuxOut(Mux2_Out));
                        MUX MUX_3 (.MuxB(PcPlus1) , .MuxA(ALUOut_PC) , .MuxSel(AND_1_Out) ,
                            .MuxOut(Mux3_Out));
                            SignExtend SE_1(.SignInputData(instruction[15:0]) , .SignOutputData(SE_1_Out));
                            ALUCtrl ALUCtrl_1 (.ALUOp(ALUOpCode) , .FuncCode(instruction[5:0]) ,
                                .ALUCtl(ALUControl) );
                                FullAdder FullAdder_1 ( .PcAdd4(PcPlus1) , .shiftOut(SE_1_Out), .ALUOut(ALUOut_PC));
                                AndGate AND_1( .input1(Zero1) , .input2(branch1) , .AndOut(AND_1_Out));
                                ControlUnit CU_1 (.Opcode(instruction[31:26]), .RegWrite(RegWrite1), .MemRead(MemRead1),
                                    .MemWrite(MemWrite1), .branch(branch1), .RegDst(RegDst1) , .ALUsrc(ALUsrc1),
                                    .MemtoReg(MemtoReg1), .jump(jump), .ALUOp(ALUOpCode));
                                    MIPSReg Register_1 (.Read1(instruction[25:21]) , .Read2(instruction[20:16]) ,
                                        .WriteReg(WriteRegAddr) , .WriteData(Mux2_Out), .Data1(RegData1) , .Data2(RegData2) ,
                                        .RegWrite(RegWrite1) , .clock(clk) ) ;
                                        MIPSALU ALU_1 (.ALUctl(ALUControl), .ALU_A(RegData1), .ALU_B(ALUIn_2),
                                            .ALUOut(ALUResult), .Zero(Zero1));
                                            DataMemory DM_1 (.Address(ALUResult), .WriteData(RegData2), .ReadData(ReadDataMem),
                                                .MemRead(MemRead1) , .MemWrite(MemWrite1), .Clock(clk));
                                                assign INST = instruction;
                                                assign PCOUT = PcPlus1;
                                                assign MEMREAD = MemRead1;
                                                assign MEMWRITE = MemWrite1;
                                                assign REGREAD1 = instruction[25:21]; assign REGDATA1 = RegData1;
                                                assign REGREAD2 = instruction[20:16]; assign REGDATA2 = RegData2;
                                                assign WRITEADDREG = WriteRegAddr; assign REGWRITEDATA = Mux2_Out;
                                                assign REGWRITE = RegWrite1;
                                                assign ALUIN = ALUIn_2;
                                                assign ALUOUT = ALUResult;
                                                assign MEMORYREAD = ReadDataMem;
                                                assign MEMWRITEDATA = RegData2;
                                                endmodule
