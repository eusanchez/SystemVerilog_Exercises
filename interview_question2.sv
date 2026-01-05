// What will be the order of printing. 


module tb;
  initial begin
    $display("%0t START", $time);

    fork
      begin
        #10 $display("%0t Thread 1", $time);
      end
      begin
        #20 $display("%0t Thread 2", $time);
      end
      begin
        #30 $display("%0t Thread 3", $time);
      end
      begin
        #10 $display("%0t Thread 4", $time);
      end
    join

    $display("%0t DONE", $time);
  end
endmodule


/* 
Thread 1 Thread 4  -> 10ns
Thread 2 -> 20ns
Thread 3 -> 30ns
*/