module model (
  input clk,
  input resetn,
  output logic div2,
  output logic div4,
  output logic div6
);

always_ff @(posedge clk) begin
  if(resetn) begin
    {div2,div4, div6} <= '0;
  end
end

task automatic clock_gen();

endtask




endmodule