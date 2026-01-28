// Code your design here
module dut #(parameter int DATA_WIDTH = 8,
             parameter int MAX = 20)
(
  input  logic                 clk,
  input  logic                 reset,   // synchronous
  input  logic                 start,   // pulse
  input  logic                 stop,    // pulse
  output logic [DATA_WIDTH-1:0] count
);
  
  logic flag;

  // TODO: you implement RTL here
  // Requirements:
  // - reset: count=0 and disabled
  // - stop has priority over start
  // - start enables counting
  // - when enabled: count increments each cycle
  // - if count reaches MAX: wrap to 0 on next enabled cycle
  
  always_ff @(posedge clk) begin
    if(reset) begin
      flag <= 0;
      count <= 0;
    end else if (stop) begin
      flag <= 0;
      count <= count;
    end else if (start || flag) begin
      flag <= 1;
      count <=  (count == MAX) ? 0 : (count + 1);
    end
    
    
  end

endmodule
