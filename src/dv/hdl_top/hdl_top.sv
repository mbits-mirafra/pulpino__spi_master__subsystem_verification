`ifndef HDL_TOP_INCLUDED_
`define HDL_TOP_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : It has axi_master_agent_bfm and spi_slave agent bfm.
//--------------------------------------------------------------------------------------------
module hdl_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //import axi_global_pkg::*;
  //-------------------------------------------------------
  // Clock Reset Initialization
  //-------------------------------------------------------
  //bit clk;
  //bit rst;

  //-------------------------------------------------------
  // Display statement for hdl_top
  //-------------------------------------------------------
  initial begin
    `uvm_info("UVM_INFO","hdl_top",UVM_LOW);
  end

  //Variable : sys_clk
  //Declaration of system clock
  bit sys_clk;

  //Variable : sys_reset_n
  //Declaration of system reset
  bit sys_reset_n;

  //-------------------------------------------------------
  //Generation of system clock at frequency rate of 20ns
  //-------------------------------------------------------
  initial begin
    sys_clk = 1'b0;
    forever #10 sys_clk =!sys_clk;
  end

  //-------------------------------------------------------
  //Generation of system sys_reset_n
  //system reset can be asserted asynchronously
  //system reset de-assertion is synchronous.
  //-------------------------------------------------------
  initial begin
    sys_reset_n = 1'b1;
    
    #15 sys_reset_n = 1'b0;

    repeat(2) begin
      @(posedge sys_clk);
    end
    sys_reset_n = 1'b1;
  end

  //-------------------------------------------------------
  // axi Interface Instantiation
  //-------------------------------------------------------
   axi4_if axi_intf(sys_clk,sys_reset_n);

  //-------------------------------------------------------
  // axi Master BFM Agent Instantiation
  //-------------------------------------------------------

  // MSHA: Use the below values for AVIP global values
  // axi_ADDR_WIDTH = 32,
  // axi_DATA_WIDTH = 64,
  
   axi4_master_agent_bfm axi4_master_agent_bfm_h(axi_intf); 

  //-------------------------------------------------------
  // spi Interface Instantiation
  //-------------------------------------------------------
  spi_if spi_intf(sys_clk,sys_reset_n);

  //-------------------------------------------------------
  // axi RTL interface Instantiation and connection
  //-------------------------------------------------------
  AXI_BUS s_axi_bus();

  // Write address channel
  assign s_axi_bus.aw_addr   = axi_intf.awaddr;
  assign s_axi_bus.aw_prot   = axi_intf.awprot;
  assign s_axi_bus.aw_region = axi_intf.awregion;
  assign s_axi_bus.aw_len    = axi_intf.awlen;
  assign s_axi_bus.aw_size   = axi_intf.awsize;
  assign s_axi_bus.aw_burst  = axi_intf.awburst;
  assign s_axi_bus.aw_lock   = axi_intf.awlock;
  assign s_axi_bus.aw_cache  = axi_intf.awcache;
  assign s_axi_bus.aw_qos    = axi_intf.awqos;
  assign s_axi_bus.aw_id     = axi_intf.awid;
  assign s_axi_bus.aw_user   = axi_intf.awuser;
  assign s_axi_bus.aw_valid  = axi_intf.awvalid;

  assign axi_intf.awready   = s_axi_bus.aw_ready;

  // Read address channel
  assign s_axi_bus.ar_addr   = axi_intf.araddr;
  assign s_axi_bus.ar_prot   = axi_intf.arprot; 
  assign s_axi_bus.ar_region = axi_intf.arregion;
  assign s_axi_bus.ar_len    = axi_intf.arlen;
  assign s_axi_bus.ar_size   = axi_intf.arsize;
  assign s_axi_bus.ar_burst  = axi_intf.arburst;
  assign s_axi_bus.ar_lock   = axi_intf.arlock;
  assign s_axi_bus.ar_cache  = axi_intf.arcache;
  assign s_axi_bus.ar_qos    = axi_intf.arqos;
  assign s_axi_bus.ar_id     = axi_intf.arid;
  assign s_axi_bus.ar_user   = axi_intf.aruser;
  assign s_axi_bus.ar_valid  = axi_intf.arvalid;

  assign axi_intf.arready   = s_axi_bus.ar_ready;

  // Write data channel
  assign s_axi_bus.w_valid   = axi_intf.wvalid;
  assign s_axi_bus.w_data    = axi_intf.wdata;
  assign s_axi_bus.w_strb    = axi_intf.wstrb;
  assign s_axi_bus.w_user    = axi_intf.wuser;
  assign s_axi_bus.w_last    = axi_intf.wlast;

  assign axi_intf.wready    = s_axi_bus.w_ready;

  // Read data channel
  assign axi_intf.rdata      = s_axi_bus.r_data ;
  assign axi_intf.rresp      = s_axi_bus.r_resp ;
  assign axi_intf.rlast      = s_axi_bus.r_last ; 
  assign axi_intf.rid        = s_axi_bus.r_id   ;
  assign axi_intf.ruser      = s_axi_bus.r_user ;
  assign axi_intf.rvalid     = s_axi_bus.r_valid;

  assign s_axi_bus.r_ready    = axi_intf.rready;

  // Write response channel
  assign axi_intf.bresp      = s_axi_bus.b_resp ;
  assign axi_intf.bid        = s_axi_bus.b_id   ;
  assign axi_intf.buser      = s_axi_bus.b_user ;
  assign axi_intf.bvalid     = s_axi_bus.b_valid;

  assign s_axi_bus.b_ready     = axi_intf.bready;
  
  //-------------------------------------------------------
  // RTL Instantiation
  //-------------------------------------------------------
  bit [1:0]spi_mode;
  bit csn1;
  bit csn2;
  bit csn3;
  bit [1:0]events;

  subsystem_top DUT
  (
       .clk                 (sys_clk),
       .reset_n             (sys_reset_n),

       .axi_slave           (s_axi_bus),

       .spi_master_clk      (spi_intf.sclk),
       .spi_master_csn0     (spi_intf.cs),
       .spi_master_csn1     (csn1),
       .spi_master_csn2     (csn2),
       .spi_master_csn3     (csn3),
       .spi_master_mode     (spi_mode),
       .spi_master_sdo0     (spi_intf.mosi0),
       .spi_master_sdo1     (spi_intf.mosi1),
       .spi_master_sdo2     (spi_intf.mosi2),
       .spi_master_sdo3     (spi_intf.mosi3),
       .spi_master_sdi0     (spi_intf.miso0),
       .spi_master_sdi1     (spi_intf.miso1),
       .spi_master_sdi2     (spi_intf.miso2),
       .spi_master_sdi3     (spi_intf.miso3)
  );

  //-------------------------------------------------------
  // spi slave agent bfm Instantiation
  //-------------------------------------------------------
  spi_slave_agent_bfm spi_agent_bfm_h(spi_intf);

endmodule : hdl_top

`endif
