module tb;

  // --------------------------
  // Signals declaration
  // --------------------------
  reg 	 		clk;
  reg [15:0]    wdata_i;
  wire [15:0] 	rdata_o;
  reg [15:0] 	rdata;
  reg 			empty;
  reg 			rd_en_i;
  reg 			wr_en_i;
  wire 			full;
  reg 			rst;
  reg 			stop;
  
  // --------------------------
  // DUT Instance
  // --------------------------
  fifo u_sync_fifo ( .rst(rst),
                         .wr_en_i(wr_en_i),
                         .rd_en_i(rd_en_i),
                         .clk(clk),
                         .wdata_i(wdata_i),
                         .rdata_o(rdata_o),
                         .empty(empty),
                         .full(full)
                        );


  // --------------------------
  // Clock generation
  // --------------------------
  always #10 clk <= ~clk;
  
  // --------------------------
  // Assertions
  // --------------------------
  
  // Assertion 1.
  // Checks , read_pointer increases when (rd_en_i & !empty) == 1
  
  read_enable_no_empty: assert property (@(posedge clk) disable iff (!rst)
                                          (rd_en_i & !empty) |=> (u_sync_fifo.read_pointer == $past(u_sync_fifo.read_pointer)+1));
    
  // Assertion 2.
  // 


  // --------------------------
  // Intial-begin
  // --------------------------
  initial begin
    clk 	<= 0;
    rst 	<= 0;
    wr_en_i 	<= 0;
    rd_en_i 	<= 0;
    stop  	<= 0;

    #50 rst <= 1;
  end

  initial begin
    @(posedge clk);

    for (int i = 0; i < 20; i = i+1) begin

      // Wait until there is space in fifo
      while (full) begin
      	@(posedge clk);
        $display("[%0t] FIFO is full, wait for reads to happen", $time);
      end;

      // Drive new values into FIFO
      wr_en_i <= $random;
      wdata_i 	<= $random;
      $display("[%0t] clk i=%0d wr_en=%0d din=0x%0h ", $time, i, wr_en_i, wdata_i);

      // Wait for next clock edge
      @(posedge clk);
    end
    stop = 1;
  end

  initial begin
    @(posedge clk);

    while (!stop) begin
      // Wait until there is data in fifo
      while (empty) begin
        rd_en_i <= 0;
        $display("[%0t] FIFO is empty, wait for writes to happen", $time);
        @(posedge clk);
      end;

      // Sample new values from FIFO at random pace
      rd_en_i <= $random;
      @(posedge clk);
      rdata <= rdata_o;
      $display("[%0t] clk rd_en=%0d rdata=0x%0h ", $time, rd_en_i, rdata);
    end

    #500 $finish;
  end
endmodule