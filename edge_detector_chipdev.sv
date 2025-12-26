/* Build a circuit that pulses dout one cycle after the rising edge of din. A pulse is defined as writing a single-cycle 1 as shown in the examples below. When resetn is asserted, the value of din should be treated as 0.

Bonus - can you enhance your design to pulse dout on the same cycle as the rising edge? Note that this enhancement will not pass our test suite, but is still a useful exercise.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
din - Input signal
dout - Output signal

Output signals during reset
dout - 0 when resetn is active */

module model (
  input clk,
  input resetn,
  input din,
  output dout
);

logic double;
logic counter;

always_ff @(posedge clk) begin
  if(!resetn) begin
    double <= '0;
    counter <= '0;
  end else begin
    if (din && (counter == 1)) begin
      double <= '0;
    end else if (din && (counter == 0)) begin
      counter <= counter + 1;
      double <= '1;
    end else if (!din) begin
        double <= '0;
        counter <= '0;
    end
  end
end

assign dout = double;

endmodule