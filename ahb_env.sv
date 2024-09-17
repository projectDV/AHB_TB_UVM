class uvm_env extends uvm_environemt;
    ahb_driver drv;
    sco sb;
    ahb_monitor mon;
    seqr seqr_h;
    v_sequencer vseqr;

    function new(string name="uvm_env",uvm_component parent);
        super.new(name,parent);
    endfunction 
    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv=ahb_driver::type_id::create("ahb_driver");
        sb=sco::type_id::create("sco");
        mon=ahb_monitor::type_id::create("ahb_monitor");
        seqr_h=seqr::type_id::create("seqr_h");
        vseqr=v_sequencer::type_id::create("vseqr");
    endfunction
    function connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.sequence_item_port.connect(seqr_h.sequence_item_export);
    endfunction
endclass
