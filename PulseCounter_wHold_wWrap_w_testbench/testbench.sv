`timescale 1ns/1ps

module tb;

  localparam int DATA_WIDTH = 8;
  localparam int MAX        = 20;

  logic clk;
  logic reset, start, stop;
  logic [DATA_WIDTH-1:0] count;

  // Instantiate DUT
  dut #(.DATA_WIDTH(DATA_WIDTH), .MAX(MAX)) u_dut (
    .clk   (clk),
    .reset (reset),
    .start (start),
    .stop  (stop),
    .count (count)
  );

  // Clock
  initial clk = 0;
  always #5 clk = ~clk;

  // Reference model state
  logic enabled;
  int unsigned exp_count;

  // Small helpers
  task automatic drive(input logic r, input logic s, input logic p);
    // Drive inputs for the *next* rising edge
    reset = r;
    start = s;
    stop  = p;
  endtask

  task automatic tick;
    @(negedge clk); // change inputs away from posedge to avoid races
    // inputs already set by drive()
    @(posedge clk);
    #1; // allow DUT to update
  endtask

  task automatic check(input string tag);
    if (count !== exp_count[DATA_WIDTH-1:0]) begin
      $display("FAIL @%0t %s | reset=%0b start=%0b stop=%0b | enabled=%0b | exp=%0d (0x%0h) got=%0d (0x%0h)",
               $time, tag, reset, start, stop, enabled,
               exp_count, exp_count[DATA_WIDTH-1:0], count, count);
      $fatal(1);
    end
    else begin
      $display("PASS @%0t %s | enabled=%0b | count=%0d", $time, tag, enabled, count);
    end
  endtask

  // Reference model update: same priorities as spec
  task automatic ref_step;
    if (reset) begin
      exp_count = 0;
      enabled   = 0;
    end
    else if (stop) begin
      enabled   = 0;
      // exp_count holds
    end
    else if (start) begin
      enabled = 1;
      // counting happens only if enabled AFTER priority handling:
      // We interpret spec as: once enabled, it increments every cycle.
      // So in same cycle as start=1, enabled becomes 1 and it should count.
      if (enabled) begin end // (placeholder)
      // We'll implement counting below using enabled_next concept.
      // Simpler: compute next enabled first, then count if next enabled is 1.
      // But since we just set enabled=1 here, we should count this cycle.
      if (exp_count == MAX) exp_count = 0;
      else                  exp_count++;
    end
    else if (enabled) begin
      if (exp_count == MAX) exp_count = 0;
      else                  exp_count++;
    end
    // else hold
  endtask

  // Safer ref model using combinational next-state
  task automatic ref_step_safe;
    logic enabled_n;
    int unsigned count_n;

    enabled_n = enabled;
    count_n   = exp_count;

    if (reset) begin
      enabled_n = 0;
      count_n   = 0;
    end
    else if (stop) begin
      enabled_n = 0;
      // count_n holds
    end
    else if (start) begin
      enabled_n = 1;
      // count in same cycle start is seen (enabled_n = 1)
      if (count_n == MAX) count_n = 0;
      else                count_n++;
    end
    else if (enabled_n) begin
      if (count_n == MAX) count_n = 0;
      else                count_n++;
    end

    enabled   = enabled_n;
    exp_count = count_n;
  endtask

  initial begin
    // init
    reset = 0; start = 0; stop = 0;
    enabled = 0;
    exp_count = 0;

    // -------- Test 0: reset works and disables ----------
    drive(1,0,0);
    ref_step_safe();
    tick();
    check("T0 reset assert");

    drive(0,0,0);
    ref_step_safe();
    tick();
    check("T0 reset deassert (hold at 0, disabled)");

    // -------- Test 1: start enables and counts ----------
    drive(0,1,0);         // start pulse
    ref_step_safe();
    tick();
    check("T1 start pulse -> should count to 1");

    // keep running for 3 cycles
    repeat (3) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
    end
    check("T1 after 3 more cycles running");

    // -------- Test 2: stop freezes ----------
    drive(0,0,1);         // stop pulse
    ref_step_safe();
    tick();
    check("T2 stop pulse -> freeze");

    // hold frozen for 2 cycles
    repeat (2) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
    end
    check("T2 still frozen");

    // -------- Test 3: stop has priority over start (same cycle) ----------
    // In same cycle both start and stop asserted: stop wins -> disabled, no counting this cycle
    // (Per your spec: stop priority over start)
    drive(0,1,1);
    ref_step_safe();
    tick();
    check("T3 start&stop same cycle -> stop wins, remain disabled");

    // Now start alone should resume and count
    drive(0,1,0);
    ref_step_safe();
    tick();
    check("T3 start after stop -> resume and count");

    // -------- Test 4: reset has top priority even if start/stop asserted ----------
    // Put into running state for a couple cycles
    repeat (2) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
    end
    check("T4 pre-reset running");

    // Assert reset with start/stop also high; reset wins -> count=0, disabled
    drive(1,1,1);
    ref_step_safe();
    tick();
    check("T4 reset dominates start/stop");

    // After reset deassert, should remain disabled until start
    drive(0,0,0);
    ref_step_safe();
    tick();
    check("T4 after reset deassert -> still disabled at 0");

    // -------- Test 5: repeated start pulses while enabled ----------
    // start while already enabled: should just keep enabled and count normally (still counts this cycle due to start)
    drive(0,1,0);
    ref_step_safe();
    tick();
    check("T5 start to enable and count");

    // start again next cycle
    drive(0,1,0);
    ref_step_safe();
    tick();
    check("T5 start again while enabled -> still counts");

    // -------- Test 6: wrap behavior ----------
    // Drive to MAX-1 while enabled, then observe wrap to 0 when hitting MAX and advancing
    // First, reset to known state
    drive(1,0,0);
    ref_step_safe();
    tick();
    check("T6 reset before wrap test");

    drive(0,1,0); // start -> count becomes 1
    ref_step_safe();
    tick();
    check("T6 start wrap test");

    // Now run until we are at MAX (or close). We'll just run many cycles and rely on scoreboard.
    // This also stresses wrap multiple times.
    repeat (MAX + 5) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
      check("T6 running wrap stress");
    end

    // -------- Test 7: stop prevents wrap/advance ----------
    // Force to near MAX then stop and ensure it holds
    drive(1,0,0);
    ref_step_safe();
    tick();
    check("T7 reset");

    drive(0,1,0);
    ref_step_safe();
    tick();
    check("T7 start");

    // Run up to MAX-1 approximately
    repeat (MAX-2) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
    end
    check("T7 near MAX");

    // Stop and hold for 3 cycles; should not change even if at MAX boundary
    drive(0,0,1);
    ref_step_safe();
    tick();
    check("T7 stop at boundary");

    repeat (3) begin
      drive(0,0,0);
      ref_step_safe();
      tick();
    end
    check("T7 held while stopped");

    // Restart and ensure counting resumes correctly
    drive(0,1,0);
    ref_step_safe();
    tick();
    check("T7 restart after stop");

    $display("\nALL TESTS PASSED ✅");
    $finish;
  end

endmodule
