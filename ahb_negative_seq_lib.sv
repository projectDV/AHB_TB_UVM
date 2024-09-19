//as this TB is only supporting single slave, I gave address for another slave which is not present by exceeding 1K boundary.
class negative_sequence_lib extends uvm_sequences;
    `uvm_object_utils(sequence_lib)
    function new(string name="sequence_lib");
        super.new(name);
    endfunction 
    function build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass
class addr_overflow_seq extdns uvm_sequence;
    `uvm_component_utils(addr_overflow_seq);
    seq_item seq;
    function new(string name="addr_overflow_seq");
        super.new(name);
    endfunction
    task body();
        seq=seq_item::type_id::create("seq");
        for(int i=0;i<10;i++) begin
        start_item(seq);
        assert(seq.randomize() with {seq.hsize=0 && seq.hwrite=1 && seq.haddr=32'd1025 && seq.hwdata=32'hdad});
        if(i==0 || i<8)
            seq.htrans=2'b10//NS
        else
            seq.htrans=2'b11//SEQ
        if(!req.randomize())
            `uvm_error(get_type_name(),"Randomization Failed");
        finish_item(seq);
        end
    endtask
endclass
