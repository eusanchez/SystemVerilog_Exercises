## Processor
Processor/CPU is the brain of the computer. It handles instructions to get the job done.
Contains:
1. Control Unit: Manages CPU by sending signals like clock, hold, and reset to its parts. Ensures the completion of components to complete tasks.
2. ALU (Arithmetic Logic Unit): Handles arithmetic tasks.
3. Memory Unit: Composed of cache memory and register. Stores data and instructions. Older CPUs used registers, modern have cache memory. CPU fetches data from RAM or ROM and stores it in register or cache during tasks.

## Instruction Cycle (5 Stages in a RISC Pipeline)
If it's not ready .... STALL. 

1. Instruction Fetch (IF)
    - Fetch instruction from memory at the address in PC
2. Instruction Decode (ID)
    - Decode instruction into opcode, and registers.
3. Execute (EX)
    - ALU performs arithmetic/logic operation
4. Memory Access (MEM)
    - Only for loads and stores.
    - Store : register -> memory
    - Load : memory -> register
5. Write Back (WB)

## Hazards in Pipelines 
1. Strucutural Hazards
    - When two or more instructions require access to the same hardware resource simultaneously.
2. Data Hazards
    - One instruction depend on the result of the previous instruction 
    - Types:
        1. RAW
        2. WAR
        3. WAW
    - **Solution**: Fowarding, instruction scheduling.
3. Control Hazards
    - Arises when the flow of instruction execution is altered by branch or jump instructions. 
    - **Solution**: Branch prediction, speculative execution, branch target buffers (BTB)
