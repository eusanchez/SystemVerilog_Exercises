// Prompt
// Design a Full Adder (FA)—the most important building block for digital computation.

// A FA is a fully combinational circuit that adds three single-bit inputs a, b, and cin (carry-in).  Inputs a and b are the two operands whereas cin represents the overflow bit carried forward from a previous addition stage.

// The FA circuit has two single-bit outputs, sum and cout—the later represents the overflow bit to be used as a carry-in to a subsequent addition stage.

// Input and Output Signals
// a - First operand input bit
// b - Second operand input bit
// cin - Carry-in input bit from a previous adder stage
// sum - Sum output bit
// cout - Carry-out (overflow) output bit to be propagated to the next addition stage


module model (
    input a,
    input b,
    input cin,
    output logic sum,
    output logic cout
);

logic [1:0] temp;

always_comb begin
    temp = a + b + cin;
    cout = temp[1];
    sum = temp[0];

end

endmodule