`include "fizzbuzz_smoke_agent.sv"

class fizzbuzz_env extends uvm_env;
    `uvm_component_utils(fizzbuzz_env)
    fizzbuzz_agent agent;

    function new(string name="fizzbuzz_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = fizzbuzz_agent::type_id::create("agent", this);
    endfunction
endclass