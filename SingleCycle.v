module SingleCycle( input clk, input reset,output[31:0] write_data ,MUX2OUT,ALUOUT,DMOUT,PCOUT,ALUINPUTA ,output[4:0] MUX1OUT,output[2:0] ALUOPOUT);



// for PC  
wire [31:0]pc_out; // initialize these variavle 

// instruction 
wire  [31:0] instruction ,adder_out;
wire [5:0]instruct1,instructlast;
wire [4:0]instruct2,instruct3,instruct4;
wire [15:0] instructpart;

//change according to book  for control unit 
wire    rfwe,dmre,dmwe,alusrc,memtoreg,branch,regdst;

wire [1:0] aluop;

// for mux1 between im and registerFile
wire [4:0] mux1_out;

//sign extended
wire [32:0] in1;

//for  mux between  regfile and  alu 
wire [31:0] alu_A, reg_data2, MUXout;

//Alu control unit control
wire [3:0] aluctlout;

//ALU 
wire[31:0]  aluout;
wire aluresult;

// data memeory operation 
wire[31:0] dmout;

// mux 3
wire[31:0] mux2_out;


//branch
wire [31:0] shiftout,pc_beq_out,mux3_out;

// and operation
wire andout;

// write back registers
wire [31:0]  m,n;

//pc 

//wire [31:0] pcin=32'b00000000000000000000000000000000;

wire [31:0] pcin;

//always @(posedge clk) begin

//PC pc(.rst(reset),.clk(clk),.PCin(32'b00000000000000000000000000000000),.PCout(pc_out));

PC pc(.rst(reset),.clk(clk),.PCin(pcin),.PCout(pc_out));
 
InstructionMemory im(.addr(pc_out),.clk(clk),.inst(instruction));


//MainControlUnit mc(.Opcode(instruction[31:26]),.RFwe(rfwe),.DMre(dmre),.DMwe(dmwe),.s1(alusrc),.s2(s2),.s3(memtoreg),.s4(Branch),.s5(regdst),.AluCtl(aluop));

MainControlUnit mc(.Opcode(instruction[31:26]),.RegDst(regdst),.ALUSrc(alusrc) ,.MemtoReg(memtoreg),.RegWrite(rfwe) ,.MemRead(dmre), .MemWrite(dmwe) ,.Branch(branch),.ALUOp(aluop));


Mux5bit mux1(.select(regdst),.a(instruction[20:16]),.b(instruction[15:11]),.q(mux1_out));


//RegisterFile regfile(.Read1(instruction[25:21]),.Read2(instruction[20:16]),.WriteReg(mux1_out),.WriteData(32'b00000000000000000000000000000000),.RegWrite(rfwe),.Data1(alu_A),.Data2(reg_data2 ),.clock(clk));




RegisterFile regfile(.Read1(instruction[25:21]),.Read2(instruction[20:16]),.WriteReg(mux1_out),.WriteData(write_data),.RegWrite(rfwe),.Data1(alu_A),.Data2(reg_data2 ),.clock(clk));

sign_extender  sge(.in(instruction[15:0]) ,.out(in1) );

//ShitLeft sl(.a(in1) , .ShitLeft2Out( shiftout));

Mux32bit mux2 (.select(alusrc ),.a( reg_data2 ),.b( in1 ),.q( MUXout ));


ALUControl aluCl(.ALUOp(aluop),.FuncCode(instruction[5:0]),.ALUCtl(aluctlout));


MIPSALU  mipsalu (.ALUctl(aluctlout), .A(alu_A), .B(MUXout), .ALUOut(aluout), .Zero(aluresult));


DataMemory  dm(.Address(aluout),.Read(dmre), .Write(dmwe),.Data(reg_data2),.clock(clk),.Data_out(dmout));

Mux32bit mux3(.select(memtoreg),.a(aluout),.b(dmout),.q(mux2_out));
 
//RegisterFile regfile1(.Read1(instruction[25:21]),.Read2(instruction[20:16]),.WriteReg(mux1_out),.WriteData(mux2_out),.RegWrite(rfwe),.Data1(m),.Data2(n),.clock(clk));

//branch  not working 
CounterIncrement ci(.a(pc_out),.b(in1),.adder_out(pc_beq_out));

AndOp andop(.a(aluresult) ,.b(branch),.AndOut(andout));

Mux32bit mux4(.select(andout),.a(pc_out),.b(pc_beq_out),.q(mux3_out));

//assign instruct1=instruction[31:26];
//assign instruct2=instruction[25:21];
//assign instruct3=instruction[20:16];
//assign instruct4=instruction[15:11];
//assign instructpart=instruction[15:0];
//assign instructlast=instruction[5:0];
assign write_data=mux2_out;
//assign pcin=mux3_out;
assign pcin = mux3_out;

assign ALUINPUTA=alu_A;
assign MUX1OUT=mux1_out;
assign MUX2OUT=MUXout ;
assign ALUOUT =aluout; 
assign DMOUT =dmout;
assign ALUOPOUT=aluop;
assign PCOUT=mux3_out;

endmodule



//very important 

//change according to book  for main control unit  done 
 
// put the proper instruction in IM module  done 

// take care of clock  don't know 

// take care of input of this module  done 

//check the order of mux  done 

//IM compare  

//put the control unit of  other arithmetic instruction(logical shift)

// for shift logical left ,change in  AluControl.v

// work on data memeory

// make initialize datamemory to  number

// initialize registers to zero 






