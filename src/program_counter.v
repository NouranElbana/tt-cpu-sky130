module program_counter (

input clk,
input reset,
input enable,
input jump,
input [7:0] jump_address,
output reg [7:0] pc_output

);

always @(posedge clk) begin
    //priotise reset --> jump --> enable --> staying the same
    if (reset) begin
        pc_output <= 8'd0;
    end

    else if (jump) begin
        pc_output <= jump_address;
    end

    else if (enable) begin
        pc_output <= pc_output + 8'd1;
    end

    else begin
        pc_output <= pc_output;
    end

end

endmodule
