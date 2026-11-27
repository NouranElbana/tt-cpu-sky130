module instruction_memory (

    input [7:0] address,
    output [15:0] instruction
);

reg [15:0] memory [0:15];
assign instruction = (address < 8'd16) ? memory[address] : 16'b0 ;

integer i;

initial begin
    for (i = 0; i < 16; i = i + 1) begin

        memory[i] = 16'b0;

    end

    //Our ROM 


    // Load initial values
    memory[0]  = 16'b1000_001_00001010_0; // LOADI R1, 10
    memory[1]  = 16'b1000_010_00010100_0; // LOADI R2, 20

    // Data Memory operations
    memory[2]  = 16'b1011_001_0011_00000; // STORE R1, [3]
    memory[3]  = 16'b1010_100_0011_00000; // LOAD R4, [3]

    // Arithmetic operations
    memory[4]  = 16'b0000_000_100_010_000; // ADD R0, R4, R2
    memory[5]  = 16'b0001_011_010_100_000; // SUB R3, R2, R4

    // Logical operations
    memory[6]  = 16'b0010_101_100_010_000; // AND R5, R4, R2
    memory[7]  = 16'b0011_110_100_010_000; // OR  R6, R4, R2
    memory[8]  = 16'b0100_111_100_010_000; // XOR R7, R4, R2
    memory[9]  = 16'b0101_000_100_000_000; // NOT R0, R4

    // Shift operations
    memory[10] = 16'b0110_011_100_000_000; // SHL R3, R4
    memory[11] = 16'b0111_101_010_000_000; // SHR R5, R2

    // JUMP 4
   memory[12] = 16'b1001_00000100_0000; 


end


endmodule
