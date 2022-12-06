// The control unit is that part of the processor which generates control signals in order to operate in the desired way depending on the instruction.
// For example: The next instruction address to be executed is PC+4 for normal cases but is calculated differently if it is a BEQ instruction.
// Let us now look at the Verilog code for the control logic, to see how much of control we have applied in the present design.

module Control_Logic
(
    instrn,
	instrn_opcode,
	address_plus_4,
	branch_address,
	ctrl_in_address,
	alu_result,
	zero_out,
	ctrl_write_en,
	ctrl_write_addr,
	read_data2,
	sign_ext_out,
	ctrl_aluin2,
	ctrl_datamem_write_en,
	datamem_read_data,
	ctrl_regwrite_data
);

input [31:0] instrn;	 
input [5:0] instrn_opcode;
input [31:0] address_plus_4;
input [31:0] branch_address;
input [31:0] datamem_read_data;
input [31:0] alu_result;
input zero_out;
input [31:0] read_data2;
input [31:0] sign_ext_out;

output wire [31:0] ctrl_in_address;
output wire ctrl_write_en;
output wire [4:0] ctrl_write_addr;
output wire [31:0] ctrl_aluin2;
output wire ctrl_datamem_write_en;
output wire [31:0] ctrl_regwrite_data;

assign ctrl_in_address = (instrn_opcode==6'h04 && zero_out) ? branch_address : address_plus_4;
assign ctrl_write_en = (instrn_opcode==6'h00) || (instrn_opcode==6'h23);
assign ctrl_write_addr = (instrn_opcode==6'h00) ? instrn[15:11] : instrn[20:16];
assign ctrl_regwrite_data = (instrn_opcode==6'h23) ? datamem_read_data : alu_result;
assign ctrl_aluin2 = (instrn_opcode==6'h23 || instrn_opcode==6'h2B) ? sign_ext_out : read_data2;
assign ctrl_datamem_write_en = (instrn_opcode==6'h2B); 

endmodule