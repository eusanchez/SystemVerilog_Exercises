class fizzbuzz_sequencer extends uvm_sequencer #(fizzbuzz_seq_item);
    `uvm_component_utils(fizzbuzz_sequencer)
    function new(string name="fizzbuzz_sequencer")
        super.new(name, parent);
    endfunction
endclass