`ifndef VIRTUAL_BASIC_WRITE_REG_SEQ_INCLUDED_
`define VIRTUAL_BASIC_WRITE_REG_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_basic_write_reg_seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class virtual_basic_write_reg_seq extends virtual_base_seq;
  `uvm_object_utils(virtual_basic_write_reg_seq)

  axi4_master_basic_write_reg_seq axi4_master_basic_write_reg_seq_h;
  spi_fd_basic_slave_seq spi_fd_basic_slave_seq_h;

  //Variable : read_key
  //Used to provide access to perform read operation
  //semaphore write_key;

  event wr_rd;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_basic_write_reg_seq");
  extern task body();
endclass : virtual_basic_write_reg_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// Parameters:
// name - virtual_basic_write_reg_seq
//--------------------------------------------------------------------------------------------
function virtual_basic_write_reg_seq::new(string name = "virtual_basic_write_reg_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task - body
// Creates a master reqister sequence and slave normal sequence
//--------------------------------------------------------------------------------------------
task virtual_basic_write_reg_seq::body();
  super.body();

  fork
    forever begin : SLAVE_SEQ
      `uvm_info("slave_vseq",$sformatf("started slave vseq"),UVM_HIGH)
      //  write_key.get(1);
      spi_fd_basic_slave_seq_h = spi_fd_basic_slave_seq::type_id::create("spi_fd_basic_slave_seq_h");
      spi_fd_basic_slave_seq_h.start(p_sequencer.spi_slave_seqr_h);
      -> wr_rd;
      //  write_key.put(1);
      `uvm_info("slave_vseq",$sformatf("ended slave vseq"),UVM_HIGH)
    end
  join_none

  repeat(2) begin
   `uvm_info("master_vseq",$sformatf("started master vseq"),UVM_HIGH)
   // write_key.get(1);
   axi4_master_basic_write_reg_seq_h = axi4_master_basic_write_reg_seq::type_id::create("axi4_master_basic_write_reg_seq_h");
   axi4_master_basic_write_reg_seq_h.model = p_sequencer.env_config_h.spi_master_reg_block;
   axi4_master_basic_write_reg_seq_h.start(p_sequencer.axi4_master_write_seqr_h);
   wait(wr_rd.triggered);
   //write_key.put(1);
   `uvm_info("master_vseq",$sformatf("ended master vseq"),UVM_HIGH)
 end
 endtask : body


`endif
