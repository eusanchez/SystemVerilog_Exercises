// Prompt
// Find the number of trailing 0s in the binary representation of the input (din). If the input value is all 0s, the number of trailing 0s is the data width (DATA_WIDTH)

// Input and Output Signals
// din - Input value
// dout - Number of trailing 0s

module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);

int i;
logic [$clog2(DATA_WIDTH):0] counter;

always_comb begin
  counter = 0;
  for (i = 0; i < DATA_WIDTH; i++) begin
    if(din[i] == 0) begin
      counter = counter + 1;
      if(din[i+1] == 1) begin
        break;
      end
    end else begin
      counter = '0;
      break;
    end
  end
end

assign dout = counter;

endmodule