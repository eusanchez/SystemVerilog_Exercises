// PACKAGE //

package shapes_pkg;
    typedef enum int { 
        triangle, 
        square
    } shape_t;

    typedef struct packed {
        int weight;
        int height;
        shape_t type_s
    } shape_t;

    function automatic int shape_area(shape_t s);
        case(s.type_s)
            triangle: return (s.width * s.height) /2;
            square: return s.width * s.width;
            default: return 0;
        endcase
    endfunction
endpackage

// TESTBENCH //

import shape_pkg::*;

program automatic tb;

shape_t queue_shape[$];

initial begin
    foreach(queue_shape[i]) begin
        int area;
        area = shape_area(queue_shape[i]);
        $display("Shape %s Area=%0d", queue_shape[i].type_s.name(), area)
    end
end


endprogram