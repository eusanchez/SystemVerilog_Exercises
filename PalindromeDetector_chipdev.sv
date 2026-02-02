// instructions: https://chipdev.io/question/18

module model #(parameter
  DATA_WIDTH=32
) (
  input [DATA_WIDTH-1:0] din,
  output logic dout
);


logic [DATA_WIDTH-1:0] reverse_bits;

function [DATA_WIDTH-1:0] reverse (input [DATA_WIDTH-1:0] din);
  for(int i =0; i < DATA_WIDTH; i++) begin
    reverse[DATA_WIDTH-1-i] = din[i];
  end
endfunction

//assign reverse_bits = reverse(din);
assign dout = (din == reverse(din));

endmodule
