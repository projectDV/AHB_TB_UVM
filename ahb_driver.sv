//driver
class ahb_driver extends uvm_driver#(seq_item);
  
  `uvm_component_utils(ahb_driver)
  
  virtual intf vif;
  
  function new(string name="ahb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("DRIVER CLASS","BUILD PHASE",UVM_NONE)
    
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal(get_full_name(),$sformatf("value of vif in driver is not obtained"))
      
     else
       `uvm_info(get_full_name(),$sformatf("value of vif in driver is obtained"),UVM_LOW)
       
  endfunction
       
       virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      seq_item tr;
      seq_item_port.get_next_item(tr);
      drive();
      seq_item_port.item_done(tr);
    end
    endtask
    
    virtual protected task drive();
      int j;
      do
        @(vif.master_cb);
      while(!vif.hrstn);
      
      vif.master_cb.hsize <= tr.hsize;
      vif.master_cb.hwrite <= tr.hwrite;
      vif.master_cb.hburst <= tr.hburst;
      
      foreach(tr.htrans[i])begin
        vif.master_cb.htrans <= tr.htrans[i];
        
        if(tr.htrans != BUSY) begin
          
          vif.master_cb.haddr <= tr.haddr[j];
          vif.master_cb.hwdata <= tr.hwdata[j];
          j++
          
        end
        
        else
          begin
          vif.master_cb.haddr <= tr.haddr[j];
          vif.master_cb.hwdata <= tr.hwdata[j];
          end
        
        do
          @(vif.master_cb);
        while(!vif.master_cb.hready);
      end
      
    endtask
    
    endclass
