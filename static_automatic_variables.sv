module tb;
    function void static_func();
        static int x = 0;
        x++;
        $display("static x = %0d", x);
    endfunction

    function automatic void automatic_func();
        int x = 0;
        x++;
        $display("static x = %0d", x);
    endfunction

    initial begin
        $display("------- STATIC --------");
        repeat(3) begin
            static_func();
        end

        $display("------ AUTOMATIC ------");
        repeat(3) begin
            automatic_func();
        end
    end
    
endmodule