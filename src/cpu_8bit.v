module cpu_8bit (
    input clk,
    input reset,
    output [7:0] pc_debug,
    output [7:0] result_debug
);

    wire [7:0] pc_address;
    wire [15:0] current_instruction;
    wire pc_enable;
    wire pc_jump;
    wire [7:0] jump_address;
    wire [3:0] opcode;
    wire [2:0] destination;
    wire [2:0] srca;
    wire [2:0] srcb;
    wire [7:0] immediate;
    wire [2:0] alu_operation;
    wire reg_write;
    wire [1:0] writeback_sel;
    wire [7:0] read_data1;
    wire [7:0] read_data2;
    wire [7:0] write_data;
    wire [7:0] alu_result;
    wire [7:0] memory_read_data;
    wire mem_write;
    wire [2:0] read_addr_a;

    assign pc_debug = pc_address;
    assign result_debug = alu_result;
    assign write_data = (writeback_sel == 2'b00) ? alu_result :
                        (writeback_sel == 2'b01) ? immediate :
                        (writeback_sel == 2'b10) ? memory_read_data :
                        8'b00000000;
    assign read_addr_a = (opcode == 4'b1011) ? destination : srca;
    
program_counter pc_inst (
    .clk(clk),
    .reset(reset),
    .enable(pc_enable),
    .jump(pc_jump),
    .jump_address(jump_address),
    .pc_output(pc_address)

);

instruction_memory imem_inst (
    .address(pc_address),
    .instruction(current_instruction)
);

instruction_decoder id_inst (
    .instruction(current_instruction),
    .opcode(opcode),
    .destination(destination),
    .srca(srca),
    .srcb(srcb),
    .immediate(immediate),
    .jump_address(jump_address)
);

control_unit cu_inst (
    .opcode(opcode),
    .alu_operation(alu_operation),
    .reg_write(reg_write),
    .writeback_sel(writeback_sel),
    .pc_enable(pc_enable),
    .pc_jump(pc_jump),
    .mem_write(mem_write)
);

register_file rf_inst (
    .clk(clk),
    .reset(reset),
    .we(reg_write),
    .write_addr(destination),
    .read_addr_a(read_addr_a),
    .read_addr_b(srcb),
    .write_data(write_data),
    .read_data_a(read_data1),
    .read_data_b(read_data2)
);

alu alu_inst (
    .A(read_data1),
    .B(read_data2),
    .opcode(alu_operation),
    .Y(alu_result)     
);

data_memory dm_inst (
    .mem_write(mem_write),
    .clk(clk),
    .reset(reset),
    .write_data(read_data1),
    .address(current_instruction[7:5]),
    .read_data(memory_read_data)
);

endmodule
