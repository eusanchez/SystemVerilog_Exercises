https://www.edaplayground.com/x/e7qv



# Stopwatch with Lap Capture and Auto-Stop

## Overview
This module implements a stopwatch-style counter with **start**, **stop**, **lap capture**, and **automatic stop on wrap**.  
The design is fully synchronous to the clock and uses pulse-based control inputs.

---

## Functional Specification

### Clocking and Reset
- The design is synchronous to the rising edge of `clk`.
- `reset` is a synchronous reset signal.
- When `reset` is asserted on a clock edge:
  - `count` is set to `0`
  - `lap_count` is set to `0`
  - `running` is set to `0` (counter disabled)

---

### Start / Stop Control
- `start` is a pulse signal.
  - When asserted on a clock edge, the counter enters the running state (`running = 1`).
- `stop` is a pulse signal.
  - When asserted on a clock edge, the counter exits the running state (`running = 0`).
- While `running = 1`, the counter increments every clock cycle.

---

### Counting Behavior
- When `running = 1`, `count` increments by 1 on each clock cycle.
- If `count` reaches `MAX`:
  - On the next enabled cycle:
    - `count` wraps back to `0`
    - `running` is automatically cleared to `0` (auto-stop)

---

### Lap Capture
- `lap` is a pulse signal.
- When `lap` is asserted on a clock edge, the current value of `count` is captured into `lap_count`.
- Lap capture works in all states:
  - While running
  - While stopped
  - While idle (no start or stop active)
- If `lap` occurs in the same cycle as a count increment, the **pre-increment** value of `count` is captured.

---

### Priority Rules (Highest to Lowest)
1. `reset`
2. `stop`
3. `start`
4. `lap`
5. Count increment / wrap / auto-stop

---

## Module Interface

```systemverilog
module dut2 #(parameter int DATA_WIDTH = 8,
              parameter int MAX = 20)
(
  input  logic                 clk,
  input  logic                 reset,     // synchronous reset
  input  logic                 start,     // pulse
  input  logic                 stop,      // pulse
  input  logic                 lap,       // pulse
  output logic                 running,   // indicates active counting
  output logic [DATA_WIDTH-1:0] count,     // current count value
  output logic [DATA_WIDTH-1:0] lap_count  // last captured lap value
);
```