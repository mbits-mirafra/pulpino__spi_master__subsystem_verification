`ifndef VIRTUAL_REG_SEQ_INCLUDED_
`define VIRTUAL_REG_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_reg_seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class virtual_reg_seq extends pulpino_spi_master_subsystem_virtual_base_seq;
  `uvm_object_utils(virtual_reg_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_reg_seq");
  extern task body();
endclass : virtual_reg_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - virtual_reg_seq
//--------------------------------------------------------------------------------------------
function virtual_reg_seq::new(string name = "virtual_reg_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task - body
// Creates a master reqister sequence and slave normal sequence
//--------------------------------------------------------------------------------------------
task virtual_reg_seq::body();
  //axi4_simple_write_read_reg_seq axi4_master_reg_seq_h;
  //spi_fd_basic_slave_seq spi_fd_basic_slave_seq_h;

  super.body();

  fork
    forever begin : SLAVE_SEQ
      `uvm_info("slave_vseq",$sformatf("started slave vseq"),UVM_HIGH)
      //spi_fd_basic_slave_seq_h = spi_fd_basic_slave_seq::type_id::create("spi_fd_basic_slave_seq");
      //spi_fd_basic_slave_seq_h.start(p_sequencer.spi_slave_seqr_h);
      `uvm_info("slave_vseq",$sformatf("ended slave vseq"),UVM_HIGH)
    end
  join_none

  `uvm_info("master_vseq",$sformatf("started master vseq"),UVM_HIGH)
  //axi4_master_reg_seq_h = axi4_simple_write_read_reg_seq::type_id::create("apb_master_reg_seq_h");
  //axi4_master_reg_seq_h.model = p_sequencer.env_config_h.spi_master_reg_block;
  //axi4_master_reg_seq_h.start(p_sequencer.axi4_master_seqr_h);
  `uvm_info("master_vseq",$sformatf("ended master vseq"),UVM_HIGH)

 endtask : body


`endif
