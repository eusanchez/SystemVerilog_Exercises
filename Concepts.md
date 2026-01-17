## Classes OOP

### Polymorphism
The same method call can behave differently depending on the actual object type. The decision of what will happen, will happen at *runtime*.

Polymorphism only works with ```virtual``` methods (in SystemVerilog/UVM). If a method is not virtual, the simulator will decide from that which method to call. 

### Inheritance

Example in **class_inheritance.sv** .

## Virtual vs Non Virtual

Virtual method call the object, meanwhile without virtual call the handle type.

In other short words, without virtual it goes with the FATHER (which is the handle) meanwhile with virtual, it goes and calls the SON (which is the object.)

Example in **virtual_and_nonvirtual.sv** .

## Static and automatic variables 

**Automatic variable** get initialized every time the scope it is declared gets executed and its stored in a different location every time.

Is basically as a RESTART, to the value erasing the value every new compilation, to replacing it to another one. Automatic can be used in functions, tasks, block (initial and always)

Example using functions:
```
function automatic int calc_area(shape_t s);
  int area;
  area = s.width * s.height;
  return area;
endfunction
```

Example using tasks:
```
task automatic print_area(shape_t s);
  int area;
  area = s.width * s.height;
  $display("area=%0d", area);
endtask
```

Example using initial..begin end:
```
initial automatic begin
  int x;
  x = 5;
end
```

Functions by defect are AUTOMATIC. 

Example with testbench in function_automatic.sv


**Static variable** gets intialized at the beginning at some memory location, and in future accesses to this variable from different threads or processes access the same memory location. 

If I declare the function static, everything becomes static, however, you will still need in some simulators to add the "static" word before the int.

Tasks by defect are STATIC.


## Packed/Unpacked Structures

A structure containt elements of different data types which can be reference as an individual or as a whole. 

Example:
```
typedef struct {
  		string fruit;
  		int    count;
  		byte 	 expiry;
	} st_fruit;
```

** TO BE CONTINUED. **

## Function vrs Task
### Function
- Must execute in zero simulation time
- CAN'T CONTAIN TIME
- Returns a value, but also allows to use *void* not returning nothing
- Can only call other functions
- Generally synthesizable

### Task
- Can contain time-consuming statements (Ex: #1; )
- CAN'T RETURN A VALUE
- Can call both tasks and functions
- Not synthesizable

*Interview example in interview_question3.sv*

## Modport
Indicates the directions of signals. 

Example using an interface and RTL:
```
interface ms_if (input clk);
  logic sready;      // Indicates if slave is ready to accept data
  logic rstn;        // Active low reset
  logic [1:0] addr;  // Address
  logic [7:0] data;  // Data

  modport slave ( input addr, data, rstn, clk,
                 output sready);

  modport master ( output addr, data,
                  input  clk, sready, rstn);
endinterface
```

```
module master ( ms_if.master mif);
	always @ (posedge mif.clk) begin

  	// If reset is applied, set addr and data to default values
    if (! mif.rstn) begin
      mif.addr <= 0;
      mif.data <= 0;

    .....
endmodule
```

## Shallow vs Deep Copy

**Shallow copy**: Copies only the reference (handle), both variables point to the same underlying object. If one is change the other one have the changes. 

```
module tb;
  Packet p1, p2;

  initial begin
    p1 = new();
    p1.data = 10;

    p2 = p1;          // SHALLOW copy
    p2.data = 20;

    $display("p1.data = %0d", p1.data);
    $display("p2.data = %0d", p2.data);
  end
endmodule
```

**Deep copy**: Copies the entire object, create a new independent object. If one change, the other one is not affected. 

```
module tb;
  Packet p1, p2;

  initial begin
    p1 = new();
    p1.data = 10;

    p2 = new();
    p2.data = p1.data;   // manual deep copy
    p2.data = 20;

    $display("p1.data = %0d", p1.data);
    $display("p2.data = %0d", p2.data);
  end
endmodule

```


## Fork - join 
For every fork and join we need an **AUTOMATIC** task, otherwise the last function call will be repeated This is because multiple threads call the same task and share the same variable in tool simulation memory. To initiate different copies of the task, the task MUST be *automatic*. 

There are three types:
1. Fork-join
2. Fork-join_none
3. Fork-join_any

## Bit vs Byte
Bit is the smallest unit of digital information, it represents either 1 or 0. 

Byte is the large unit of digital information made up of eight bits. 

** 1 Byte = 8 Bits **

## $clog2

Number of ones possible in a value. 

Example:
```
$clog2(2) --> 1 bit
$clog2(15) --> 4 bit --> 15 in binary is 1111 which is 4 bits that can be 1. 
```

2 Values can be represented using only 1 bit --> 1 and 0.

## & vs && 









