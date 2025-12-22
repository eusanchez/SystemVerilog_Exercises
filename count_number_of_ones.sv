// Testbench
module top;  
  initial begin
    int unsigned number = $urandom();
    int unsigned count = 0;
    int unsigned tmp = 0;
    
    tmp = number;
    
     
    
    // INSTRUCTIONS:
    // Write SystemVerilog code to count how many
    // bits are equal to 1 in the variable 'number'
    // and store the result in 'count'.
    //
    // Rules:
    // - Do NOT use $countones
    // - Use bitwise operations
    // - You may modify a copy of 'number' if needed
    

    // >>> WRITE YOUR CODE HERE <<<
    while (tmp) begin
      if (tmp & 1) begin
        $display("count: %0d", count);
        count += 1;
      end
      tmp = tmp >> 1;
    end

    $display("number orig: 32'b%b", number);
    $display("count: %0d", count);
  end
endmodule