// FIFO an array of DEPTH elements, and each elemt is WIDTH bits wide
module fifo #(parameter DEPTH = 32,
              parameter WIDTH = 16
) 
(
    input logic clk_i,
    input logic rst_n_i,

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

logic [WIDTH-1:0] FIFO [DEPTH];



endmodule