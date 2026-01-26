// Code your testbench here
// or browse Examples
import fifo_pkg::*;

program automatic tb_fifo;
  fifo_t my_fifo;
  bit [WIDTH-1:0] data_out;
  bit success;
  
  initial begin
    // Initialize FIFO
    my_fifo.write_ptr = 0;
    my_fifo.read_ptr = 0;
    my_fifo.count = 0;
    
    $display("\n=== FIFO Test ===");
    
    // Test 1: Push some data
    $display("\nPushing data...");
    push(my_fifo, 32'hDEADBEEF);
    push(my_fifo, 32'hCAFEBABE);
    push(my_fifo, 32'h12345678);
    $display("FIFO count: %0d", my_fifo.count);
    
    // Test 2: Pop data
    $display("\nPopping data...");
    pop(my_fifo, data_out, success);
    if (success) $display("Popped: 0x%h", data_out);
    
    pop(my_fifo, data_out, success);
    if (success) $display("Popped: 0x%h", data_out);
    
    // Test 3: Fill FIFO
    $display("\nFilling FIFO...");
    for (int i = 0; i < DEPTH; i++) begin
      push(my_fifo, i);
    end
    $display("Is full? %0d", is_full(my_fifo));
    
    // Test 4: Try to overfill
    $display("\nTrying to push when full...");
    push(my_fifo, 32'hFFFFFFFF);
    
    // Test 5: Empty FIFO
    $display("\nEmptying FIFO...");
    while (!is_empty(my_fifo)) begin
      pop(my_fifo, data_out, success);
      if (success) $display("Popped: 0x%h", data_out);
    end
    $display("Is empty? %0d", is_empty(my_fifo));
  end
endprogram