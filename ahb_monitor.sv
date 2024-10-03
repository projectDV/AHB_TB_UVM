class monitor extends uvm_monitor;
    `uvm_component_utils("monitor")

    virtual intf vif;
    tb_cfg cfg;
    uvm_analysis_port#(txn)mon_port;
    transaction txn;

    virtual function new(string name="monitor",uvm_component parent);
        super.new(name,parent);
        txn=new("txn",this);
    endfunction
    virtual function build_phase(uvm_phase phase);
        super.build_phase();
        mon_port=new("mon_port",this);
       
    endfunction
    function connect_phase(uvm_phase phase);
        super.connect_phase();
        if(!uvm_config_db#(virtual intf)::get("this","","vif_cfg",cfg))
            `uvm_error("Failed");
        else
            this.vif=cfg.vif;
    endfunction
    virtual task run_phase(uvm_phase phase);
        forver begin
        @(vif.mon_cb);
        seq_item_port.get_next_item(tnx);
        if(read)
            monitor();
        end
        seq_item_port.item_done();
        end
    endtask
    virtual task monitor();
        @(vif.mon_cb);
        if(rst) begin
        txn.sig_a=0;
        txn.sig_b=0;
        end
        else
        fork begin
            txn.sig_a=vif.sig_a;
            txn.sig_b=vif.sig_b;
        end
            mon_port.write(txn);
    endtask
    
class ahb_monitor extends uvm_monitor;
    `uvm_component_utils(ahb_monitor)
    virtual interface vif;
    uvm_analysis_port#(seq_item)ap;
    seq_item txn;
    tb_cfg cfg;

    function new(string name="ahb_monitor", uvm_component parent);
        super.new(name,parent);
        ap=new();
    endfunction
    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db(virtual interface)::get(this,"","top_vif",cfg))
            `uvm_error(get_type_name(),"NOT SET AT TOP")
    endfunction
    function connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        this.vif=cfg.vif;
    endfunction
    task run_phase(uvm_phase phase)
        fork
            forever begin   
                txn=seq_item::type_id::create("txn");
                @(vif.monitor_cb)
                monitor();
                ap.write(txn);
            end
        join
    endtask
    task monitor();
        
        if(!(vif.master_cb.hresetn))
            if(vif.master_cb.htrans==IDLE)  
                
                txn.haddr=vif.haddr;
                
                txn.hwdata=vif.hwdata;
                
                txn.hwrite=vif.hwrite;
                
                txn.hburst=vif.hburst;
                
                txn.hsize=vif.hsize;
                
                txn.htrans=vif.htrans;
                
                txn.hready=vif.hready;
                
                txn.hrdata=vif.hrdata;
                
                txn.hresp=vif.hresp;
    endtask
endclass
