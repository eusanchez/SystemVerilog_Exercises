module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

parameter RES0 = 0,
          RES1 = 1,
          RES2 = 2;

logic [1:0] state, next_state;

always_ff @(posedge clk) begin
  if(!resetn) begin
    state <= RESET;
  end else begin
    state <= next_state;
  end
end

always_comb begin
  case(state) 
  RESET: begin
    dout = '0;
    next_state = (value % 3 == 0) ? RES0 : (value % 3 == 1) ? RES1 : RES2;
  end
  RES1: begin
    dout = '0;
    next_state = (value == 0) ? RES0 : ( value % 3 == 1) ? RES1 : RES2; 
  end
  RES2: begin
    dout = '0;
    next_state = (value == 0) ? RES0 : ( value % 3 == 1) ? RES1 : RES2;  

  end
  RES0: begin
    dout = '1;
    next_state = (value == 0) ? RES0 : ( value % 3 == 1) ? RES1 : RES2; 

  end
  default: next_state = RESET;  
  endcase

end


endmodule