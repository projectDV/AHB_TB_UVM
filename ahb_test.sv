//test
`include "package.svh"

class ahb_test extends uvm_test;
  
  `uvm_component_utils(ahb_test);
  
  ahb_env env;
    
  function new(string name ="ahb_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=ahb_env::type_id::create("env",this);
    
    `uvm_info("TEST CLASS", "BUILD PHASE", UVM_NONE)
  endfunction
  
  task run_phase(uvm_phase phase);
    
    ahb_seq1 seq1;
    seq1=ahb_seq::type_id::create("seq1");
    
    phase.raise_objection(this,"starting seq1 in main phase");
    $display("%t starting seq1 in run phase",$time);
    seq1.start(env.seqr);
    #100ns;
    phase.drop_objection(this,"finished seq1 in main phase");
    
    
  endtask
  
endclass

class child_test extends ahb_test;
  `uvm_component_utils(child_test)
  //V_SEQ
  addr_overflow_seq seq_o;//negative test
  
  function new(string name="child_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    
    seq_o=ahb_seq1::type_id::create("seq_o");
    phase.raise_objection(this,"started seq2 in main phase");
    $display("%t starting seq2 in run phase",$time);
    seq_o.start(env.seqr);
    #100ns;
    phase.drop_objection(this,"finished seq2 in main phase");
  endtask
  
endclass
