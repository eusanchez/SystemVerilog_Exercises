////////////////////////////////////////////////////////////////////////////////
// EXERCISE 1: FIFO Operations using Tasks
// 
// GOAL: Implement a basic FIFO (First-In-First-Out) queue with push/pop operations
//
// INSTRUCTIONS:
// 1. Implement the 'push' task:
//    - Check if FIFO is full (count >= DEPTH)
//    - If full: print error message and return
//    - If not full: 
//      * Store data_in at data[write_ptr]
//      * Increment write_ptr (use modulo DEPTH to wrap around: write_ptr = (write_ptr + 1) % DEPTH)
//      * Increment count
//      * Print a message showing what was pushed
//
// 2. Implement the 'pop' task:
//    - Check if FIFO is empty (count == 0)
//    - If empty: print error, set success=0, data_out=0, and return
//    - If not empty:
//      * Read data from data[read_ptr] into data_out
//      * Increment read_ptr (use modulo DEPTH to wrap around)
//      * Decrement count
//      * Set success=1
//
// 3. Implement 'is_full' function:
//    - Return 1 if count equals DEPTH, otherwise return 0
//
// 4. Implement 'is_empty' function:
//    - Return 1 if count equals 0, otherwise return 0
//
// HINTS:
// - Use 'ref' for fifo parameter so you can modify it
// - Use 'output' for values you want to return from tasks
// - Functions can only return one value
////////////////////////////////////////////////////////////////////////////////