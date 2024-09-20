//SB
class ahb_sb extends uvm_scoreboard;
  //fact_reg
  `uvm_component_utils(ahb_sb)
  //analysis port
  `uvm_analysis_import#(txn,ahb_sb)ap_sb;
  seq_item txn, ref_txn;
  int mem[int];//sparse arr
  //construct and phases
  function new(string name="ahb_sb",uvm_component parent);
    super.new(name,parent);
    ap_sb=new();
    mem=new();
  endfunction 
  function build_phase(uvm_phase phase);
    super.build_phase(phase);
    txn=seq_item::type_id::create("txn");
  endfunction
  task run_phase(uvm_phase phase);
    ap_sb.get(txn);//monitor->sb
    txn.copy(ref_txn)//reference_txn
    ref(txn);//expected
    compare(txn);
  endtask
  //ref_model
  //write
  //read
  task ref(txn t);
    if(t.pwrite)
      mem[t.haddr]=t.hwdata;
    else
      t.hrdata=mem[t.haddr];
  endtask
  //compare
 task compare(txn t);
  if(txn.compare(ref_txn))
    `uvm_info("PASS");
    else
    `uvm_info("FAIL");
 endtask
endclass
