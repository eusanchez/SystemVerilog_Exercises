package fizzbuzz_smoke_pkg;

  import uvm_pkg::*;
    `include "uvm_macros.svh"

    // IMPORTANTE: incluye en orden de dependencias
    `include "fizzbuzz_smoke_transaction.sv"
    `include "fizzbuzz_smoke_sequencer.sv"
    `include "fizzbuzz_smoke_driver.sv"
    `include "fizzbuzz_smoke_agent.sv"
    `include "fizzbuzz_smoke_env.sv"
    `include "fizzbuzz_smoke_sequence.sv"
    `include "fizzbuzz_smoke_test.sv"

endpackage