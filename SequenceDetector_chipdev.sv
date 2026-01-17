module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

logic first,second,third, fourth;

always_comb begin
  fourth = third;
  third = second;
  second = first;
  first = din;
end

always_ff @(posedge clk) begin
  if(!resetn) begin
    dout <= 1'b0;
    {first,second,third,fourth} <= 1'b0;
  end else begin
    if ((first ~^ third) && (second ~^ fourth)) begin
      dout <= 1'b1;
    end else begin
      dout <= 1'b0;
    end
  end

end

endmodule