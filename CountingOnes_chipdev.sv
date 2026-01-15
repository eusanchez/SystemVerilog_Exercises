module model #(parameter
  DATA_WIDTH = 16
) (
  input [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);

logic [$clog2(DATA_WIDTH):0] count; // In order to know how many ones to count, I need to know how many times I can have one, like the maximum amount, this is why we use $clog2

always_comb begin
  count = 0;
  for(int i=0; i < DATA_WIDTH; i++) begin
    if (din[i] == 1'b1) begin
        count += 1;
    end
  end
end

assign dout = count;

endmodule