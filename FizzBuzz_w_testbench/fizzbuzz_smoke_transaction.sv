class fizzbuzz_seq_item extends uvm_sequence_item;

    rand int unsigned reset_low_cycles;
    rand int unsigned run_cycles;

    `uvm_object_utils_begin(fizzbuzz_seq_item)
        `uvm_field_int(reset_low_cycles, UVM_DEFAULT)
        `uvm_field_int(run_cycles, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name ="fizzbuzz_seq_item");
        super.new(name);
    endfunction

    constraints c_defaults {
        reset_low_cycles inside {[1:10]}
        run_cycles inside {[5:200]}
    }
endclass