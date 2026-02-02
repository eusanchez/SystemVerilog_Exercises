`include "fizzbuzz_smoke_interface.sv"

class fizzbuzz_driver extends uvm_driver #(fizzbuzz_seq_item);

    `uvm_component_utils(fizzbuzz_driver)

    virtual fizzbuzz_if vif;

    function new(string name="fizzbuzz_driver", uvm_component parent=null)
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase)
        if(!uvm_config_db#(virtual fizzbuzz_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF","virtual interface is missing, 'vif' not set")
    endfunction

    task run_phase(uvm_phase phase);
        fuzzbuzz_seq_item tr;

        //Default safe value
        vif.resetn <= 1'b0;

        forever begin
            seq_item_port.get_next_item(tr);

            `uvm_info("DRV", $sformatf("Driving reset: low %0d cycles, then run %0d cycles", tr.reset_low_cycles, tr.run_cycles), UVM_LOW)

            // Synchronous, active-low reset: drive on clock edges
            vif.resetn <= 1'b0;
            repeat (tr.reset_low_cycles) @(posedge vif.clk);

            vif.resetn <= 1'b1;
            repeat (tr.run_cycles) @(posedge vif.clk);

            seq_item_port.item_done();
        end
    endtask
endclass