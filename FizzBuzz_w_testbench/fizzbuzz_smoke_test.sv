`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fizzbuzz_smoke_interface.sv"


class fizzbuzz_smoke_test extends uvm_test;

    `uvm_component_utils(fizzbuzz_smoke_test)

    //Calling the virtual interface
    virtual fizzbuzz_if vif;

    function new(string name="fizzbuzz_smoke_test", uvm_componenet parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual fizzbuzz_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF","virtual interface 'vif' not set via uvm_config_db")
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        //synchronous active-low reset: hold low for 2 cycles, then release
        vif.resetn <= 1'b0;
        repeat(2) @(posedge vif.clk);
        vif.resetn <= 1'b1;

        // observe a handful of cycles
        repeat (25) begin
            @(posedge vif.clk);
            `uvm_info("SMOKE", $sformatf("resetn=%0b fizz=%0b buzz=%0b fizzbuzz=%0b", vif.resetn, vif.fizz, vif.buzz, vif.fizzbuzz), UVM_LOW)
        end

        phase.drop_objection(this);
    endtask
endclass