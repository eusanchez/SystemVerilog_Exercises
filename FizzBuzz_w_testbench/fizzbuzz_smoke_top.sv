
import uvm_pkg::*;
import fizzbuzz_smoke_pkg::*;
`include "uvm_macros.svh"



module tb_top;
    logic clk = 0;
    always #5 clk = ~clk;

    fizzbuzz_if fb_if(clk);

    // Small MAX_CYCLES for faster wrap-around later
    model #(.FIZZ(3), .BUZZ(5), .MAX_CYCLES(20)) dut (
        .clk      (clk),
        .resetn   (fb_if.resetn),
        .fizz     (fb_if.fizz),
        .buzz     (fb_if.buzz),
        .fizzbuzz (fb_if.fizzbuzz)
    );

    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars(0, tb_top);
    // end

    initial begin
        fb_if.resetn = 1'b0;
        uvm_config_db#(virtual fizzbuzz_if)::set(null, "*", "vif", fb_if);
        run_test("fizzbuzz_seq_test");
    end
endmodule