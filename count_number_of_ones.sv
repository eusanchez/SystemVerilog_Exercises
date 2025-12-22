// Testbench
module top;  
  initial begin
    static int number = $urandom();
    static int count = 0;   
    
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
    

    $display("number orig: 32'b%b", number);
    $display("count: %0d", count);
  end
endmodule
