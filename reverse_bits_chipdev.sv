module model #(parameter
  DATA_WIDTH=32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);


always_comb begin
  for (int i = 0; i < DATA_WIDTH; i++) begin
    dout[i] = din[DATA_WIDTH-i-1];
  end
end

/* 
Case 1: 1101 -> [0] = 1, [1] = 1, [2] = 0, [3] = 1

dout = 0000

first cycle:  dout[0] = din[4-0-1] = din[3]
second cycle: dout[1] = din[4-1-1] = din[2]
third cycle: dout[2] = din[4-2-1] = din[1]
fourth cycle: dout[2] = din[4-3-1] = din[0]

*/


endmodule