# FIFO (First In First Out)

- Ensures that data is processed in the order it was received, which is critical for maintaining data integrity.

## Synchronous FIFO 
Its synchronized clock to control the read and write operations. 

The read and write pointers of the FIFO are updated synchronously with the clocks, and data is transferred betweem the FIFO and the external circuit synchronously with the clocks.

Inputs and outputs are:

![Synchronous FIFO I/O](images/sync_fifo.svg)
