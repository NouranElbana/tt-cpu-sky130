module control_unit (

    input [3:0] opcode,
    output wire [2:0] alu_operation,
    output reg reg_write,
    output reg [1:0] writeback_sel,   // 00 = ALU, 01 = immediate, 10 = data memory
    output reg pc_enable,
    output reg pc_jump,
    output reg mem_write

);

assign alu_operation= opcode[2:0];

always @(*) begin

    reg_write= 1'b0;
    writeback_sel= 2'b00;
    pc_enable= 1'b0;
    pc_jump= 1'b0;
    mem_write = 1'b0;

    case (opcode)

    //For all our 8 operations
    4'b0000, 4'b0001, 4'b0010, 4'b0011,
    4'b0100, 4'b0101, 4'b0110, 4'b0111: begin
        reg_write = 1'b1;
        writeback_sel= 2'b00;
        pc_enable= 1'b1;
        pc_jump= 1'b0;
    end

    //For LOADI operations
        4'b1000: begin
        reg_write = 1'b1;
        writeback_sel= 2'b01;
        pc_enable= 1'b1;
        pc_jump= 1'b0;
    end

    //For Jump operations
        4'b1001: begin
        reg_write = 1'b0;
        writeback_sel= 2'b00;
        pc_enable= 1'b0;
        pc_jump= 1'b1;
    end

    //For memory carry operation (load)
    4'b1010: begin
        reg_write = 1'b1;
        writeback_sel= 2'b10;
        pc_enable= 1'b1;
        pc_jump= 1'b0;
        mem_write = 1'b0;
    end

    //For memory write operation (store)
    4'b1011: begin
        reg_write = 1'b0;
        writeback_sel= 2'b00;
        pc_enable= 1'b1;
        pc_jump= 1'b0;
        mem_write = 1'b1;
    end


    endcase
end
endmodule
