`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_sequencer
// Creates master and slave sequences here
//--------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
  `uvm_component_utils(virtual_sequencer)

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  axi4_master_write_sequencer axi4_master_write_seqr_h;

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  axi4_master_read_sequencer axi4_master_read_seqr_h;

  // Variable: slave_seqr_h
  // Declaring slave sequencer handle
  spi_slave_sequencer spi_slave_seqr_h;

  //Variable: env_config_h
  //Declaring handle for env_config_object
  env_config env_config_h;  

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_sequencer", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function virtual_sequencer::new(string name = "virtual_sequencer",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds the master and slave sequencers here.
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  axi4_master_write_seqr_h = axi4_master_write_sequencer::type_id::create("axi4_master_write_seqr_h",this);
  axi4_master_read_seqr_h = axi4_master_read_sequencer::type_id::create("axi4_master_read_seqr_h",this);
  spi_slave_seqr_h = spi_slave_sequencer::type_id::create("spi_slave_seqr_h",this);
endfunction : build_phase

`endif
