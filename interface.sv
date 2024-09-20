interface intf;
  logic hclk,hrstn;
  logic [31:0] haddr;
  logic [31:0] hwdata;
  logic [2:0] hburst;
  logic [2:0] hsize;
  logic [1:0] htrans;
  logic hwrite;
  
  logic hready;
  logic [31:0] hrdata;
  logic hresp;
  
  clocking master_cb @(posedge hclk);
    output haddr, hwdata, hwrite, hburst, hsize, htrans;
    input hready, hrdata, hresp;
  endclocking
  
  clocking slave_cb @(posedge hclk);
    input haddr, hwdata, hwrite, hburst, hsize, htrans;
    output hready, hrdata, hresp;
  endclocking
  
  clocking monitor_cb @(posedge hclk);
    input haddr, hwdata, hwrite, hburst, hsize, htrans,hready, hrdata, hresp;
  endclocking
  
  modport master(clocking master_cb);
  modport slave(clocking slave_cb);
  modport passive(clocking monitor_cb);
   
endinterface
