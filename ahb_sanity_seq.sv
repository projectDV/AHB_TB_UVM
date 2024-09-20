class ahb_seq1 extends uvm_sequence#(seq_item); //test case with transfer type=NS, burst size=0 and size=0
  `uvm_object_utils(ahb_seq1)
  
  function new(string name="ahb_seq1");
    super.new(name);
  endfunction
  
  task body();
    
    seq_item seq2;
    seq2=seq_item::type_id::create("seq2");
    
    //generate 40 transactions
    for(int i=0;i<40;i++) begin
    start_item(seq2);
      assert(seq2.randomize() with (seq2.hburst=3'b000 && seq2.hsize=3'b000 && seq2.haddr<=32'd1024));
      //alternating write & read operation
      if(i % 2 == 0) begin //write operation
        seq2.hwrite=1'b1;
        seq2.hwdata = $urandom;
        `uvm_info("AHB_SEQ",$sformatf("Write transaction %0d: i,haddr=%0d,hwdata=%0d",i,haddr,hwdata)
                 
       end
       else begin
         seq2.hwrite=1'b0;
         `uvm_info("AHB_SEQ",$sformatf("Read transaction %0d: i,haddr=%0d",i,haddr)
       end
                   
      //common transaction fields
      
        if(i==0 && i%9==0)begin
        seq2.htrans=2'b10;//NS
        end
                   else begin
                     seq2.htrans=2'b11;//S
                   end
    finish_item(seq2);
    end
    
                   endtask
      endclass
