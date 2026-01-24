module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic onehot
);

int counter = 0;

always_comb begin
  counter = 0;
  for(int i=0 ; i < DATA_WIDTH ; i++) begin
    if(din[i] == 1'b1) begin
      counter = counter + 1;
    end
  end
end

assign onehot = (counter == 1) ? 1'b1 : 1'b0;

endmodule