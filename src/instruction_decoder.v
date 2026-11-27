module instruction_decoder (

    input [15:0] instruction,
    output [3:0] opcode,
    output [2:0] destination,
    output [2:0] srca,
    output [2:0] srcb,
    output [7:0] immediate,
    output [7:0] jump_address

);

    assign opcode       = instruction[15:12];
    assign destination  = instruction[11:9];
    assign srca         = instruction[8:6];
    assign srcb         = instruction[5:3];
    assign immediate    = instruction[8:1];
    assign jump_address = instruction[11:4];    

endmodule
