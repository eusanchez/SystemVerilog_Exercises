module model (
  input clk,
  input resetn,
  input [4:0] init,
  input din,
  output logic seen
);

logic [4:0] correct_pattern; 
logic [4:0] seq;

always @(posedge clk) begin
  if(!resetn) begin
    seq <= '0;
    correct_pattern <= init;
  end else begin
    seq <= {seq, din};
  end
end

assign seen = (seq == correct_pattern) ? '1 : '0;
endmodule