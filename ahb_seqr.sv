class ahb_seqr extends uvm_sequencer#(ahb_seq_item);
  
  `uvm_component_utils(ahb_seqr)
  
  
  function new(string name="ahb_seqr",uvm_component parent);
    super.new(ahb_seqr,parent);
  endfunction
  
endclass
