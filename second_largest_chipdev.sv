/* Given a clocked sequence of unsigned values, output the second-largest value seen so far in the sequence. If only one value is seen, then the output (dout) should equal 0. Note that repeated values are treated as separate candidates for being the second largest value.

When the reset-low signal (resetn) goes low, all previous values seen in the input sequence should no longer be considered for the calculation of the second largest value, and the output dout should restart from 0 on the next cycle.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
din - Input data sequence
dout - Second-largest value seen so far

Output signals during reset
dout - 0 when resetn is active

 */


module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] reg_largest;
logic [DATA_WIDTH-1:0] reg_slargest;

always_ff @(posedge clk) begin
  if (!resetn) begin
    dout <= '0;
    reg_largest <= '0;
  end else begin
    if (reg_largest < din) begin
      dout <= reg_largest;
      reg_largest <= din;
    end else if (dout < din) begin
      dout <= din;
    end
  end  
end
endmodule