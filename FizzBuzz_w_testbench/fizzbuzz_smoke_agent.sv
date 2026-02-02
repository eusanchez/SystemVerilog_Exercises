`include "fizzbuzz_smoke_sequencer.sv"
`include "fizzbuzz_smoke_driver.sv"

class fizzbuzz_agent extends uvm_agent;

    `uvm_component_utils(fizzbuzz_agent)

    fizzbuzz_sequencer seqr;
    fizzbuzz_driver drv;

    function new(string name="fizzbuzz_agent", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(uvm_phase phase);
        seqr = fizzbuzz_sequencer::type_id::create("seqr", this);
        drv = fizzbuzz_driver::type_id::create("drv",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass