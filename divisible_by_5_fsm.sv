module divisible_by_5_fsm (
    input logic clk,
    input logic rst_n,
    input logic bit_in, 
    output logic divisible
);
    typedef enum logic [2:0] {
        S0, //0
        S1, //1
        S2, //10
        S3, //11
        S4 //100  
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin 
        if(!rst_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
        S0: next_state = bit_in ? S1 : S0;
        S1: next_state = bit_in ? S3 : S2;
        S2: next_state = bit_in ? S0 : S4;
        S3: next_state = bit_in ? S2 : S1;
        S4: next_state = bit_in ? S4: S3;
        default: next_state = S0;
        endcase
    end

    always_comb begin
        divisible = (current_state == S0);
    end

endmodule


///////////////////////////
////////// TEST //////////
///////////////////////////

`timescale 1ns/1ps

module tb_divisible_by_5;

    logic clk;
    logic rst_n;
    logic bit_in;
    logic divisible;

    // Instantiate DUT
    divisible_by_5_fsm dut (
        .clk(clk),
        .rst_n(rst_n),
        .bit_in(bit_in),
        .divisible(divisible)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task to send a binary string MSB -> LSB
    task send_binary(input string bin);
        int i;
        begin
            for (i = 0; i < bin.len(); i++) begin
                bit_in = (bin[i] == "1");
                @(posedge clk);
                $display("Input bit=%0b | divisible=%0b", bit_in, divisible);
            end
            $display("Final result for %s => divisible=%0b\n",
                     bin, divisible);
        end
    endtask

    initial begin
        // Initialize
        clk   = 0;
        bit_in = 0;
        rst_n = 0;

        // Reset
        #12;
        rst_n = 1;

        // Test cases
        send_binary("0101"); // 5
        send_binary("1111"); // 15
        send_binary("1010"); // 10
        send_binary("1001"); // 9 (not divisible)
        send_binary("0");    // 0

        #20;
        $finish;
    end

endmodule
