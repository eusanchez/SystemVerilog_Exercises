///////////////////////
/// USING FUNCTION ///
/////////////////////

package shapes_pkg;

  typedef enum { triangle, square } shape_s;

  typedef struct {
    int     width;
    int     height;
    shape_s type_s;
  } shape_t;

  function automatic int calc_area(shape_t s);
    case (s.type_s)
      triangle: return (s.width * s.height) / 2;
      square:   return s.width * s.height;
      default:  return 0;
    endcase
  endfunction

endpackage

//------------- TESTBENCH --------------//

import shapes_pkg::*;

program automatic tb;

  shape_t queue_shape[$];

  initial begin
    queue_shape.push_back('{4, 3, triangle});
    queue_shape.push_back('{5, 5, square});

    foreach (queue_shape[i]) begin
      int area;
      area = calc_area(queue_shape[i]);
      $display("Shape=%s Area=%0d",
               queue_shape[i].type_s.name(),
               area);
    end
  end

endprogram



///////////////////////
//// USING CLASSES ///
/////////////////////


package shapes_pkg;

  typedef enum { triangle, square } shape_s;

  typedef struct {
    int     width;
    int     height;
    shape_s type_s;
  } shape_t;

  class AreaCalc;
    function int calc(shape_t s);
      case (s.type_s)
        triangle: return (s.width * s.height) / 2;
        square:   return s.width * s.height;
        default:  return 0;
      endcase
    endfunction
  endclass

endpackage

//------------- TESTBENCH --------------//

import shapes_pkg::*;

program automatic tb;

  shape_t queue_shape[$];
  AreaCalc area_calc;

  initial begin
    area_calc = new();  

    queue_shape.push_back('{4, 3, triangle});
    queue_shape.push_back('{5, 5, square});

    foreach (queue_shape[i]) begin
      int area;
      area = area_calc.calc(queue_shape[i]);
      $display("Shape=%s Area=%0d",
               queue_shape[i].type_s.name(),
               area);
    end
  end

endprogram


