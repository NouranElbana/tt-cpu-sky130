module register_file(
    input clk,
    input reset,
    input we,
    input [2:0] write_addr,     //Selects which register to write
    input [7:0] write_data,     //Value to store
    input [2:0] read_addr_a,    //Selects first register to read
    input [2:0] read_addr_b,    //Selects second register to read
    output [7:0] read_data_a,   //First register value
    output [7:0] read_data_b    //Second register value
   
);

 reg [7:0] R [0:7]; //creates eight 8-bit storage entries: R[0], R[1], R[2], R[3].......
 integer i;

 always @(posedge clk) begin
    
    if (reset) begin    //if reset= 1 update all 8 registers to 0
        for (i = 0; i < 8; i = i + 1) begin
        R[i] <= 8'd0;
        end
    end

    else if (we) begin  //else if we= 1 store write_data in whichever register write_addr selects
        R[write_addr] <= write_data; 
    end

end

assign read_data_a = R[read_addr_a];    //reading from the 1st regsiter selected (MUX A)
assign read_data_b = R[read_addr_b];    //reading from the 2nd regsiter selected (MUX B)

endmodule
