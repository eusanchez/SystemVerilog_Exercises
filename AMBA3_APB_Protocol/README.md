## What is APB 
APB is a simple, non-pipelined bus [^1] used for low-speed peripherals.

Properties:
- Synchronous (only reacts on rising edge of PCLK)
- Every transfer takes more than 2 cycles.



[^1] Only one transfer can be in progress at a time, and the next transfer cannot start until the current one fully finishes.