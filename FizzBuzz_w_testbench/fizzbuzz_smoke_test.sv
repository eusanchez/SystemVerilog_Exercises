`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fizzbuzz_smoke_interface.sv"


class fizzbuzz_seq_test extends uvm_test;
    `uvm_component_utils(fizzbuzz_seq_test)

    fizzbuzz_env env;

    function new(string name="fizzbuzz_seq_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = fizzbuzz_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        fizzbuzz_basic_seq seq;

        phase.raise_objection(this);

        seq = fizzbuzz_basic_seq::type_id::create("seq");
        seq.start(env.agent.seqr);

        phase.drop_objection(this);
  endtask
endclass