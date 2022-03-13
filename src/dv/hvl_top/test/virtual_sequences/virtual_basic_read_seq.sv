`ifndef virtual_basic_read_seq_INCLUDED_
`define virtual_basic_read_seq_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_basic_read_seq
// Creates and starts the master and slave vd_vws sequnences of variable data and variable 
// wait states.
//--------------------------------------------------------------------------------------------
class virtual_basic_read_seq extends virtual_base_seq;
  `uvm_object_utils(virtual_basic_read_seq)

  //Variable : axi4_master_8b_seq_h
  //Instatiation of axi4_master_8b_seq
  axi4_master_basic_read_seq axi4_master_basic_read_seq_h;
  //axi4_master_std_read_seq axi4_master_std_read_seq_h;

  //Variable : spi_fd_basic_slave_seq_h 
  //Instantiation of spi_fd_basic_slave_seq 
  spi_fd_basic_slave_seq  spi_fd_basic_slave_seq_h;

  //Variable : read_key
  //Used to provide access to perform read operation
  semaphore read_key;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="virtual_basic_read_seq");
  extern task body();

endclass : virtual_basic_read_seq
//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - virtual_basic_read_seq
//--------------------------------------------------------------------------------------------

function virtual_basic_read_seq::new(string name ="virtual_basic_read_seq");
  super.new(name);
  read_key = new(1);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task - body
// Creates and starts the 8bit data of master and slave sequences
//--------------------------------------------------------------------------------------------
task virtual_basic_read_seq::body();
  super.body();
  axi4_master_basic_read_seq_h = axi4_master_basic_read_seq::type_id::create("axi4_master_basic_read_seq_h");
  //axi4_master_std_read_seq_h = axi4_master_std_read_seq::type_id::create("axi4_master_std_read_seq_h");
  spi_fd_basic_slave_seq_h = spi_fd_basic_slave_seq::type_id::create("spi_fd_basic_slave_seq_h");

   fork
    forever begin
      `uvm_info("slave_vseq",$sformatf("started slave vseq"),UVM_HIGH)
      read_key.get(1);
      spi_fd_basic_slave_seq_h.start(p_sequencer.spi_slave_seqr_h);
      read_key.put(1);
      `uvm_info("slave_vseq",$sformatf("ended slave vseq"),UVM_HIGH)
    end
  join_none

  repeat(2) begin
    `uvm_info("master_vseq",$sformatf("started master vseq"),UVM_HIGH)
    read_key.get(1);
    axi4_master_basic_read_seq_h.start(p_sequencer.axi4_master_write_seqr_h);
    //axi4_master_std_read_seq_h.start(p_sequencer.axi4_master_seqr_h);
    read_key.put(1);
   //#100us;
    `uvm_info("master_vseq",$sformatf("ended master vseq"),UVM_HIGH)
  end
 endtask : body

`endif
