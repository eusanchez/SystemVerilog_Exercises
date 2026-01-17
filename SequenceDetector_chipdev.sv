// Prompt
// Given a stream of input bits, pulse a 1 on the output (dout) whenever a b1010 sequence is detected on the input (din).

// When the reset-low signal (resetn) goes active, all previously seen bits on the input are no longer considered when searching for b1010.

// Input and Output Signals
// clk - Clock signal
// resetn - Synchronous reset-low signal
// din - Input bits
// dout - 1 if a b1010 was detected, 0 otherwise
// Output signals during reset
// dout - 0 when resetn is active

module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

parameter IDLE = 0,
          S1 = 1,
          S10 = 2,
          S101 = 3,
          S1010 = 4;

logic [2:0] next_state, state;

always_comb begin
  case(state)
    IDLE: begin
      next_state = din ? S1 : IDLE;
      dout = '0;
    end
    S1: begin
      next_state = din ? S1 : S10;
      dout = '0;
    end
    S10: begin
      next_state = din ? S101 : IDLE;
      dout = '0;
    end
    S101: begin
      next_state = din ? S1 : S1010;
      dout = '0;
    end
    S1010: begin
      next_state = din ? S101 : IDLE;
      dout = '1;
    end
    default: next_state = IDLE;
  endcase
end

always_ff @(posedge clk) begin
  if(!resetn) begin
    state <= IDLE;
  end
  else begin
    state <= next_state;
  end
end


endmodule