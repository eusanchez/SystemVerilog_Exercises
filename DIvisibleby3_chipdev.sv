module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

    parameter MODR=0, MOD0=1, MOD1=2, MOD2=3;
    logic [1:0] state;

    always @(posedge clk) begin
        if (!resetn) begin
            state <= MODR;
        end else begin
            case (state)
                MODR: state <= (din ? MOD1 : MOD0);
                MOD0: state <= (din ? MOD1 : MOD0);
                MOD1: state <= (din ? MOD0 : MOD2);
                MOD2: state <= (din ? MOD2 : MOD1);
            endcase
        end
    end

    assign dout = (state == MOD0);

endmodule