`include "fizzbuzz_smoke_transaction.sv"

class fizzbuzz_basic_seq extends uvm_sequencer #(fizzbuzz_seq_item);

    `uvm_object_utils(fizzbuzz_basic_seq)

    function new(string name="fizzbuzz_basic_seq");
        super.new(name);
    endfunction

    task body();
        // from fizzbuzz_smoke_transaction.sv
        fizzbuzz_seq_item tr;
        
        tr= fizzbuzz_seq_item::type_id::create("tr");
        // In transaction we made a constraint where reset_low_cycles could go form [1:10], in here we are stating that for this approach, this should be 2. 
        if(!tr.randomize() with {reset_low_cycles == 2; run_cycles == 40;})
            `uvm_fatal("RAND","Randomize failed")

        start_item(tr);
        finish_item(tr);
    endtask

endclass
