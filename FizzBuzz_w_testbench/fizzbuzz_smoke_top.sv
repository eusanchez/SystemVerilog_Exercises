
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "fizzbuzz_smoke_interface.sv"
`include "fizzbuzz_smoke_test.sv"


module tb_top;

logic clk = 0;
always #5 clk = ~clk;

fizzbuzz_if fb_if(clk);

// DUT instantiation (use smaller MAX_CYCLES so wrap happens quickly)
model #(.FIZZ(3), .BUZZ(5), .MAX_CYCLES(20)) dut (
    .clk(clk),
    .resetn(fb_if.resetn),
    .fizz(fb_if.fizz),
    .buzz(fb_if.buzz),
    .fizzbuzz(fb_if.fizzbuzz)
);

initial begin
    fb_if.resetn = 1'b0; //safe default before UVM starts
    uvm_config_db#(virtual fizzbuzz_if)::set(null, "*", "vif", fb_if);
    run_test("fizzbuzz_smoke_test");
end


endmodule