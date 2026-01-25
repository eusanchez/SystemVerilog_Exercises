# FIFO (First In First Out)

- Ensures that data is processed in the order it was received, which is critical for maintaining data integrity.

## Synchronous FIFO 
Its synchronized clock to control the read and write operations. 

The read and write pointers of the FIFO are updated *synchronously* with the clocks, and data is transferred betweem the FIFO and the external circuit synchronously with the clocks.

Inputs and outputs are:

![Synchronous FIFO I/O](images/sync_fifo.svg)

This ones are used to buffer data when the rate of data transfer exceeds the rate of data processing.

## Depth and width.
The depth of the FIFO refers to the total number of data entries it can hold at any given time.  

It determines how many data elements the FIFO can temporarily store while the writer and reader are running at different speeds. 

This is important because writer and reader do NOT operate at the same rate. FIFO help with that mismatch.

$$
\text{Depth} = \frac{\text{Writing Rate} - \text{Reading Rate}}{\text{Clock Frequency}}
$$

## I/O ports

Some of the most important ports are:

1. Status Flags: Indicates when is *FULL* and no more data can be written until some is read.

2. Write and read data ports signals, writer is the input while reader is the output of the data to be read. 




