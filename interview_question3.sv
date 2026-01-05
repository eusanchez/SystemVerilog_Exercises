// If the same task is called 3 times in a fork ... join, how do you prevent shared state from getting overwritten/racing ?

//Code given (example)

module tb;

task do_op(input int in);
    int tmp; //in this moment this variable is static
    tmp = in * 2;
    result = tmp;
endtask 

initial begin
    fork
        do_op(1);
        do_op(2);
        do_op(3);
    join

    $display("result =%0d", result);
end
    
endmodule

/* WRONG things about this:
- do_op is staic
- tmp is shared across all calls
- result is shared */

module tb;

task automatic do_op(input int in, output int out);
    int tmp; //in this moment this variable is static
    tmp = in * 2;
    result = tmp;
endtask 

int r1, r2, r3;


initial begin
    fork
        do_op(1, r1);
        do_op(2, r2);
        do_op(3, r3);
    join

    $display("r1=%0d r2=%0d r3=%0d", r1, r2, r3);
end
    
endmodule

/* The solution is adding the AUTOMATIC to the task.  */