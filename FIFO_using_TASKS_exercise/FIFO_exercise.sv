// Code your design here
package fifo_pkg;
  parameter DEPTH = 8;
  parameter WIDTH = 32;
  
  typedef struct {
    bit [WIDTH-1:0] data[DEPTH];
    int write_ptr;
    int read_ptr;
    int count;
  } fifo_t;
  
  // TODO: Implement the push task
  task automatic push(ref fifo_t fifo, input bit [WIDTH-1:0] data_in);
    if(fifo.count >= DEPTH) begin
      $error("FIFO is full.");
    end else begin
      fifo.data[fifo.write_ptr] = data_in;
      fifo.write_ptr = (fifo.write_ptr + 1) % DEPTH;
      fifo.count = fifo.count + 1;
      $display("data_in %0b has been push to data[%0d]", data_in, fifo.write_ptr);
    end
  endtask
  
  // TODO: Implement the pop task
  task automatic pop(ref fifo_t fifo, output bit [WIDTH-1:0] data_out, output bit success);
    if(fifo.count == 0) begin
      $error("FIFO is empty");
      success = '0;
      data_out = '0;
    end else begin
      data_out = fifo.data[fifo.read_ptr];
      fifo.read_ptr = (fifo.read_ptr + 1) % DEPTH;
      fifo.count = fifo.count - 1;
      success =  '1;
    end
  endtask
  
  // TODO: Implement the is_full function
  function automatic bit is_full(fifo_t fifo);
    if(fifo.count == DEPTH) begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
  
  // TODO: Implement the is_empty function
  function automatic bit is_empty(fifo_t fifo);
    if(fifo.count == 0) begin
      return 1;
    end else begin
      return 0;
    end
  endfunction
  
endpackage
