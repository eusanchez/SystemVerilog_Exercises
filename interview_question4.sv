/*
PROBLEM (Interview prompt):
- Given a 32-bit input word data_in, swap the positions of two nibbles (4-bit fields).
- A nibble is 4 bits. A 32-bit word contains 8 nibbles total.
- The nibble positions are provided as:
    position_one : logic [3:0]
    position_two : logic [3:0]
    where each position is interpreted as an integer nibble index.

- Example:
    data_in = 32'h12345678
    nibbles = {1,2,3,4,5,6,7,8} from MSB to LSB
    swapping position 1 (nibble '7') with position 7 (nibble '1')
    -> data_out = 32'h72345618

WHY position_one/position_two CAN BE USED AS INTS:
- Even though position_* are declared as logic [3:0], they represent a binary number.
- In arithmetic/indexing contexts, SystemVerilog treats them as unsigned integers,
  so (position_one * 4) correctly computes a bit index.

  EDA: https://www.edaplayground.com/x/8qw2
*/


module swap_nibbles (
    input logic [31:0] data_in,
    input logic [3:0] position_one,
    input logic [3:0] position_two,
    output logic [31:0] data_out
);
    logic [31:0] temp;

    logic [3:0] nibble_one, nibble_two;
    
    always_comb begin
      	temp = data_in;
      
        nibble_one = data_in[(position_one*4) +: 4]; //grabbing position one
        nibble_two = data_in[(position_two*4) +: 4]; //grabbing position two

        temp[(position_one*4) +: 4] = nibble_two;
        temp[(position_two*4) +: 4] = nibble_one;
    end

    assign data_out = temp;

endmodule

/* TESTBENCH 

module tb;

    logic [31:0] data_in;
    logic [3:0]  position_one;
    logic [3:0]  position_two;
    logic [31:0] data_out;

    // Instantiate DUT
    swap_nibbles dut (
        .data_in(data_in),
        .position_one(position_one),
        .position_two(position_two),
        .data_out(data_out)
    );

    initial begin
        // Test 1: Example from interview
        data_in      = 32'h12345678;
        position_one = 4'd1;
        position_two = 4'd7;
        #1;
        $display("IN=%h  pos1=%0d pos2=%0d  OUT=%h",
                  data_in, position_one, position_two, data_out);

        // Test 2: Swap lowest two nibbles
        data_in      = 32'hDEADBEEF;
        position_one = 4'd0;
        position_two = 4'd1;
        #1;
        $display("IN=%h  pos1=%0d pos2=%0d  OUT=%h",
                  data_in, position_one, position_two, data_out);

        // Test 3: Swap middle nibbles
        data_in      = 32'hCAFEBABE;
        position_one = 4'd3;
        position_two = 4'd4;
        #1;
        $display("IN=%h  pos1=%0d pos2=%0d  OUT=%h",
                  data_in, position_one, position_two, data_out);

        $finish;
    end

endmodule






*/