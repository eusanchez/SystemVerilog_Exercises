module model (
  input clk,
  input resetn,
  input [4:0] init,
  input din,
  output logic seen
);

parameter BIT0 = 0,
          BIT1 = 1,
          BIT2 = 2,
          BIT3 = 3,
          BIT4 = 4,
          IDLE = 5;

logic [2:0] state, next_state;

logic first, second;

always_ff @(posedge clk) begin
  if(!resetn) begin
    state <= IDLE;
  end else begin
    state <= next_state;
  end
end

always_comb begin
  case(state) 
    IDLE: begin
      if(resetn) begin
        next_state = BIT0;
      end else begin
        next_state = IDLE;
      end
    end
    BIT0: begin
      if(init[0] == din) begin
        first = din;
        next_state = BIT1;
      end else begin
        next_state = BIT0;
      end
    end
    BIT1: begin
      if(init[1] == din) begin
        second = din;
        next_state = BIT2;
      end else begin
        next_state = BIT1;
      end
    end
    BIT2: begin
      if(init[2] == din) begin
        next_state = BIT3;
      end else if (first == din) begin
        next_state = BIT1;
      end else begin
        next_state = BIT0;
      end
    end
    BIT3: begin
      if(init[3] == din) begin
        next_state = BIT4;
      end else begin
        next_state = BIT0;
      end
    end
    BIT4:
      if(init[4] == din) begin
        next_state = IDLE;
        seen = '1;
      end
    default: next_state = IDLE;
  endcase
end

endmodule