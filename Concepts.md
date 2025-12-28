## Classes OOP

### Inheritance

Example in **class_inheritance.sv** .

## Virtual vs Non Virtual

Virtual method call the object, meanwhile without virtual call the handle type.

In other short words, without virtual it goes with the FATHER (which is the handle) meanwhile with virtual, it goes and calls the SON (which is the object.)

Example in **virtual_and_nonvirtual.sv** .

## Static and automatic variables 

**Automatic variable** get initialized every time the scope it is declared gets executed and its stored in a different location every time.

Is basically as a RESTART, to the value erasing the value every new compilation, to replacing it to another one.

**Static variable** gets intialized at the beginning at some memory location, and in future accesses to this variable from different threads or processes access the same memory location. 

If I declare the function static, everything becomes static, however, you will still need in some simulators to add the "static" word before the int.

By default functions and variables are automatic.

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






