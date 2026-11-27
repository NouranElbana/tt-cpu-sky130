module data_memory (

    input clk,
    input reset,
    input mem_write,    // STORE sets mem_write = 1
    input [7:0] write_data, //what value to write
    input [2:0] address,    //which location to access
    output [7:0] read_data   // tells the cpu what value is stored at the selected address

);

reg [7:0] memory [0:7];
assign read_data = memory[address];
integer i;

always @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 8; i = i + 1) begin
            memory[i] <= 8'b0;
        end
    end

    else if (mem_write) begin

    memory[address] <= write_data;

    end
end


endmodule
