// FIFO an array of DEPTH elements, and each elemt is WIDTH bits wide
module fifo #(parameter DEPTH = 32,
              parameter WIDTH = 16
) 
(
    input logic clk,
    input logic rst,

    //--------------------------------
    // Write
    //--------------------------------
    input logic [WIDTH-1:0] wdata_i,
    input logic wr_en_i,
    output logic full_o,

    //--------------------------------
    // Read
    //--------------------------------
    input logic rd_en_i,
    output logic empty_o,
    output logic [WIDTH-1:0] rdata_o
);

// Using $clog2 helps determine how many bits the address has to be to achieve the FIFO DEPTH
localparam ADDR_WIDTH = $clog2(DEPTH);

// Status Flags
logic full, empty;

// Read and Write Pointers
// They need to be of size ADDR_WIDTH since pointers are picking a specific address as its victim.
logic [ADDR_WIDTH-1:0] read_pointer, write_pointer;

logic [WIDTH-1:0] fifo [DEPTH];

always_ff @(posedge clk) begin
    if(!rst) begin
        write_pointer <= '0;
    end else begin
        if (wr_en_i & !full) begin
            fifo[write_pointer] <= wdata_i;
            write_pointer <= write_pointer + 1;
        end
    end 
end

always_ff @(posedge clk) begin
    if(!rst) begin
        read_pointer <= '0;
    end else begin
        if (rd_en_i & !empty) begin
            rdata_o <= fifo[read_pointer];
            read_pointer <= read_pointer + 1;
        end
    end
end

assign full = ((write_pointer + 1) == read_pointer); // if 1, it means it has no space to write, it has DEPTH valid entries being occupied.
assign empty = (write_pointer == read_pointer); // if 1, it means fifo has zero valid entries, meaning that it has nothing to read.

endmodule