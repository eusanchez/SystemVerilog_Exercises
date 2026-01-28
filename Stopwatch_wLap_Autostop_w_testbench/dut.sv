module dut2 #(parameter int DATA_WIDTH = 8,
              parameter int MAX = 20)
(
  input  logic                 clk,
  input  logic                 reset,   // sync
  input  logic                 start,   // pulse
  input  logic                 stop,    // pulse
  input  logic                 lap,     // pulse
  output logic                 running,
  output logic [DATA_WIDTH-1:0] count,
  output logic [DATA_WIDTH-1:0] lap_count
);

  // TODO: implement

  always_ff @(posedge clk) begin
    if(reset) begin
      count <= '0;
      lap_count <= '0;
      running <= '0;
    end else if(stop) begin
      running <= '0;
      if(lap) begin
        lap_count <= count;
      end
    end else if (start || running) begin
      running <= '1;
      if(count == MAX) begin
        count <= '0;
        running <= '0;
      end else begin
        count <= count + 1;
      end
      if(lap) begin
        lap_count <= count;
      end
    end else
      if(lap) begin
        lap_count <= count;
      end
  end
endmodule
