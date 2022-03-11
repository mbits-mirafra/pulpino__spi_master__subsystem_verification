`ifndef virtual_base_seq_INCLUDED_
`define virtual_base_seq_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_base_seq
// Holds the handle of actual sequencer.
//--------------------------------------------------------------------------------------------
class virtual_base_seq extends uvm_sequence;
  `uvm_object_utils(virtual_base_seq)
  
  //Declaring p_sequencer
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  //variable : apb_master_vsqr_h
  //Declaring handle to the virtual sequencer
  axi4_master_write_sequencer  axi4_master_write_seqr_h;
  //axi4_master_read_sequencer  axi4_master_read_seqr_h;  
 
  //variable : spi_slave_vsqr_h
  //Declaring handle to the virtual sequencer
  spi_slave_sequencer spi_slave_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_base_seq");
  extern task body();
endclass : virtual_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - virtual_base_seq
//--------------------------------------------------------------------------------------------
function virtual_base_seq::new(string name = "virtual_base_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Used to connect the master virtual seqr to master seqr
//
// Parameters:
//  name - virtual_base_seq
//--------------------------------------------------------------------------------------------
task virtual_base_seq::body();
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
  
  axi4_master_write_seqr_h = p_sequencer.axi4_master_write_seqr_h;
  //axi4_master_read_seqr_h = p_sequencer.axi4_master_read_seqr_h;
  
  spi_slave_seqr_h  = p_sequencer.spi_slave_seqr_h;

endtask : body

`endif
