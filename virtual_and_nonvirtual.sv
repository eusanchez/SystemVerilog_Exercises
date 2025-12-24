// Declaring classes 

class A_nonvirtual;
    function void display();
        $display("A_nonvirtual.display (FATHER)");
    endfunction
endclass


class B_nonvirtual extends A_nonvirtual;
    function void display();
        $display("B_nonvirtual.display (SON)");
    endfunction //new()
endclass 


class A_virtual;
    virtual function void display();
        $display("A_virtual.display (FATHER)");
    endfunction
endclass


class B_virtual extends A_virtual;
    virtual function void display();
      // virtual in here makes nothing because for this virtual. to "work" there should me another 
        $display("B_virtual.display (SON)");
    endfunction //new()
endclass 

module tb;
    A_nonvirtual p1;
    B_nonvirtual n1;

    A_virtual p2;
    B_virtual n2;

    initial begin
        $display("==================================");
        $display(" THIS EXAMPLE IS WITHOUT VIRTUAL ");
        $display("==================================");

        n1 = new();
        p1 = n1;

        $display("P1 printing without VIRTUAL METHOD");
        p1.display();

        $display("==================================");
        $display(" THIS EXAMPLE IS WITH VIRTUAL ");
        $display("==================================");

        n2 = new();
        p2 = n2;

        $display("P1 printing with VIRTUAL METHOD");
        p2.display();
    end
endmodule

