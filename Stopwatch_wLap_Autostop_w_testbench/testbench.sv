`timescale 1ns/1ps

module tb;

  localparam int DATA_WIDTH = 8;
  localparam int MAX        = 10;

  logic clk;
  logic reset, start, stop, lap;
  logic running;
  logic [DATA_WIDTH-1:0] count, lap_count;

  dut2 #(.DATA_WIDTH(DATA_WIDTH), .MAX(MAX)) u_dut (
    .clk(clk), .reset(reset), .start(start), .stop(stop), .lap(lap),
    .running(running), .count(count), .lap_count(lap_count)
  );

  // clock
  initial clk = 0;
  always #5 clk = ~clk;

  // reference model
  logic ref_running;
  int unsigned ref_count;
  int unsigned ref_lap;

  task automatic drive(input logic r, input logic s, input logic p, input logic l);
    reset = r; start = s; stop = p; lap = l;
  endtask

  task automatic tick;
    @(negedge clk);
    @(posedge clk);
    #1;
  endtask

  task automatic ref_step;
    logic next_running;
    int unsigned next_count;
    int unsigned next_lap;

    next_running = ref_running;
    next_count   = ref_count;
    next_lap     = ref_lap;

    // Priority: reset > stop > start > lap > count/wrap/autostop
    if (reset) begin
      next_running = 0;
      next_count   = 0;
      next_lap     = 0;
    end
    else begin
      if (stop)  next_running = 0;
      else if (start) next_running = 1;

      // lap captures "current count of this cycle" (before increment/wrap)
      if (lap) next_lap = next_count;

      // counting happens after control + lap
      if (next_running) begin
        if (next_count == MAX) begin
          next_count   = 0;
          next_running = 0; // AUTO-STOP on wrap event
        end
        else begin
          next_count++;
        end
      end
    end

    ref_running = next_running;
    ref_count   = next_count;
    ref_lap     = next_lap;
  endtask

  task automatic check(input string tag);
    if (running !== ref_running ||
        count   !== ref_count[DATA_WIDTH-1:0] ||
        lap_count !== ref_lap[DATA_WIDTH-1:0]) begin
      $display("FAIL @%0t %s", $time, tag);
      $display("  IN : reset=%0b start=%0b stop=%0b lap=%0b", reset, start, stop, lap);
      $display("  EXP: running=%0b count=%0d lap=%0d", ref_running, ref_count, ref_lap);
      $display("  GOT: running=%0b count=%0d lap=%0d", running, count, lap_count);
      $fatal(1);
    end
    else begin
      $display("PASS @%0t %s | run=%0b count=%0d lap=%0d",
               $time, tag, running, count, lap_count);
    end
  endtask

  initial begin
    // init
    reset=0; start=0; stop=0; lap=0;
    ref_running=0; ref_count=0; ref_lap=0;

    // T0 reset
    drive(1,0,0,0); ref_step(); tick(); check("T0 reset");
    drive(0,0,0,0); ref_step(); tick(); check("T0 deassert (hold)");

    // T1 lap while stopped (should capture 0)
    drive(0,0,0,1); ref_step(); tick(); check("T1 lap stopped captures 0");

    // T2 start then count 3 cycles
    drive(0,1,0,0); ref_step(); tick(); check("T2 start -> count increments");
    repeat(2) begin
      drive(0,0,0,0); ref_step(); tick();
    end
    check("T2 after 3 total increments");

    // T3 lap while running (capture current count before increment)
    drive(0,0,0,1); ref_step(); tick(); check("T3 lap running captures pre-incr");

    // T4 stop + lap same cycle (stop first, lap captures current count)
    drive(0,0,1,1); ref_step(); tick(); check("T4 stop&lap: stop then lap");

    // T5 hold stopped (no count change)
    repeat(2) begin
      drive(0,0,0,0); ref_step(); tick();
    end
    check("T5 stopped holds");

    // T6 start again and run until wrap autostop triggers
    drive(0,1,0,0); ref_step(); tick(); check("T6 restart");

    // Run enough cycles to cross MAX
    repeat(50) begin
      drive(0,0,0,0); ref_step(); tick();
      check("T6 running stress");
      if (!ref_running && ref_count==0) begin
        $display("Autostop observed at time %0t", $time);
        break;
      end
    end

    // T7 after autostop, ensure it stays stopped unless start
    repeat(2) begin
      drive(0,0,0,0); ref_step(); tick();
    end
    check("T7 stays stopped after autostop");

    // T8 reset dominates all
    drive(1,1,1,1); ref_step(); tick(); check("T8 reset dominates");

    $display("\nALL TESTS PASSED ✅");
    $finish;
  end

endmodule
