`ifndef AXI4_MASTER_BASIC_WRITE_SEQ_INCLUDE_
`define AXI4_MASTER_BASIC_WRITE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_basic_write_seq
// Extends the axi4_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class axi4_master_basic_write_seq extends axi4_master_base_seq;
  `uvm_object_utils(axi4_master_basic_write_seq)

  string status_reg   = "STATUS_REG_SEQ"   ;
  string clkdiv_reg   = "CLOCK_DIV_REG_SEQ";
  string spi_len_reg  = "SPI_LEN_REG_SEQ"  ;
  string tx_fifo      = "TX_FIFO_SEQ"      ;
  string rx_fifo      = "RX_FIFO_SEQ"      ;
  string spi_cmd_reg  = "SPI_CMD_REG_SEQ"  ;
  string spi_addr_reg = "SPI_ADDR_REG_SEQ" ;
  string dummy_reg    = "DUMMY_REG_SEQ"    ;
  string interupt_reg = "INTERUPT_REG_SEQ" ;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="axi4_master_basic_write_seq");
  extern task body();
  endclass : axi4_master_basic_write_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_master_basic_write_seq
//--------------------------------------------------------------------------------------------
function axi4_master_basic_write_seq::new(string name="axi4_master_basic_write_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task axi4_master_basic_write_seq::body();
  super.body();
  //req=axi4_master_tx::type_id::create("req");
  //req.axi4_master_agent_cfg_h = p_sequencer.axi4_master_agent_cfg_h;

 

  start_item(req);
  if(!req.randomize() with {//req.pselx == SLAVE_0;
                            //req.awaddr == 32'h1A10_2004;
                            //req.pwdata == 32'h0000_0000;  
                            req.transfer_type == BLOCKING_WRITE;
                            //req.cont_write_read == 0;
                            //req.pwrite == WRITE;
                          }) begin  
    `uvm_fatal("axi4","Rand failed");
  end
  `uvm_info(clkdiv_reg,$sformatf("clkdiv_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
  finish_item(req);


 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2008;
 //                           req.pwdata == 32'hffff_ffff;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : SPICMD
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(spi_cmd_reg,$sformatf("spi_cmd_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);


 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_200c;
 //                           req.pwdata == 32'h0fA9_ffff;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : SPIADDR
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(spi_addr_reg,$sformatf("spi_addr_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);


 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2010;
 //                           req.pwdata == 32'h0010_1010;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : SPILEN
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(spi_len_reg,$sformatf("spi_len_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);

 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2014;
 //                           req.pwdata == 32'h0002_0000;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : SPIDUM
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(dummy_reg,$sformatf("dummy_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);


 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2018;
 //                           req.pwdata == 32'h0000_f01A;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : TXFIFO
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(tx_fifo,$sformatf("tx_fifo_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);


////  start_item(req);
////  if(!req.randomize() with {req.pselx == SLAVE_0;
////                            req.paddr == 32'h1A10_2020;
////                            req.pwdata == 32'h0000_ff11;  
////                            req.transfer_size == BIT_32;
////                            req.cont_write_read == 0;
////                            req.pwrite == WRITE;}) begin : RXFIFO
////    `uvm_fatal("axi4","Rand failed");
////  end
////  `uvm_info(rx_fifo,$sformatf("rx_fifo_reg_seq= \n %0p",req.sprint()),UVM_MEDIUM)
////  finish_item(req);


 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2024;
 //                           req.pwdata == 32'hDF1F_1F1F;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : INTCFG 
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(interupt_reg,$sformatf("interupt_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);
 // 
 // start_item(req);
 // if(!req.randomize() with {req.pselx == SLAVE_0;
 //                           req.paddr == 32'h1A10_2000;
 //                           req.pwdata == 32'h0000_0102;  
 //                           req.transfer_size == BIT_32;
 //                           req.cont_write_read == 0;
 //                           req.pwrite == WRITE;}) begin : STATUS_REG
 //   `uvm_fatal("axi4","Rand failed");
 // end
 // `uvm_info(status_reg,$sformatf("status_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
 // finish_item(req);

 // 
////  start_item(req);
////  if(!req.randomize() with {req.pselx == SLAVE_0;
////                            req.paddr == 32'h1A10_2000;
////                            req.pwdata == 32'h0000_0012;  
////                            req.transfer_size == BIT_32;
////                            req.cont_write_read == 0;
////                            req.pwrite == WRITE;}) begin : STATUS_REG_SRST
////    `uvm_fatal("axi4","Rand failed");
////  end
////  `uvm_info(status_reg,$sformatf("status_reg_seq = \n %0p",req.sprint()),UVM_MEDIUM)
////  finish_item(req);

endtask : body



`endif
