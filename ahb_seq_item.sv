class seq_item extends uvm_sequence_item;
  
  rand bit [31:0] Haddr;
  rand bit Hwrite;
  rand bit [31:0] Hwdata;
  rand bit [1:0]Htrans;
  rand bit [2:0]Hburst;
  rand bit [2:0]Hsize;
  
  bit [1:0]Hresp;
  bit [31:0]Hrdata;
  bit Hready;
  
  `uvm_object_utils_begin
  
  `uvm_int_field(Haddr,UVM_ALL)
  `uvm_int_field(Hwrite,UVM_ALL)
  `uvm_int_field(Hwdata,UVM_ALL)
  `uvm_int_field(Htrans,UVM_ALL)
  `uvm_int_field(Hwdata,UVM_ALL)
  `uvm_int_field(Htrans,UVM_ALL)
  `uvm_int_field(Hburst,UVM_ALL)
  `uvm_int_field(Hsize,UVM_ALL)
  `uvm_int_field(Hresp,UVM_ALL)
  `uvm_int_field(Hrdata,UVM_ALL)
  `uvm_int_field(Hready,UVM_ALL)
  
  `uvm_object_utils_end
  
  function new(string name="seq_item");
    super.new(name);
  endfunction
     function do_compare(uvm_object rhs, uvm_comparer comparer);
        sequence_item seq;
        $cast(seq,rhs);
        return super.do_compare(rhs,comparer)&&
        haddr==seq.haddr&&
        hwdata==seq.hwdata&&
        hburst==seq.hburst&&
        hsize==seq.hsize&&
        htrans==seq.trans&&
        hready==seq.ready&&
        hrdata==seq.hrdata&&
    endfunction
  
endclass
