module model (
  input clk,
  input resetn,
  output logic div2,
  output logic div4,
  output logic div6
);

logic counter2;
logic [1:0] counter4;
int counter6;

always_ff @(posedge clk) begin
  if(!resetn) begin
    counter2 <= '0;
    counter4 <= '0;
    counter6 <= '0;
  end else begin
    counter2 <= counter2 + 1;
    counter4 <= counter4 + 1;
    counter6 <= (counter6 + 1) % 6;
  end
end

assign div2 = (counter2 == 1);
assign div4 = (counter4 == 1) || (counter4 == 2);
assign div6 = (counter6 == 1) || (counter6 == 2) || (counter6 == 3);


endmodule