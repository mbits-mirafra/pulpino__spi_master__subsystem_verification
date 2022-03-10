`ifndef BASIC_WRITE_TEST_INCLUDED_
`define BASIC_WRITE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_8b_write_test
// Extends the base test and starts the virtual sequence
//--------------------------------------------------------------------------------------------
class basic_write_test extends base_test;
  `uvm_component_utils(basic_write_test)
  
  //Variable :virtual_basic_write_seq_h 
  //Instatiation of virtual_basic_write_seq
  virtual_basic_write_seq virtual_basic_write_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "basic_write_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : basic_write_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - basic_write_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function basic_write_test::new(string name = "basic_write_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Creates the axi4_virtual_8b_seq sequnce and starts the 8b virtual sequences
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task basic_write_test::run_phase(uvm_phase phase);
  
  virtual_basic_write_seq_h = virtual_basic_write_seq::type_id::create("virtual_basic_write_seq_h");

  `uvm_info(get_type_name(),$sformatf("basic_write_test"),UVM_LOW);
  phase.raise_objection(this);
  virtual_basic_write_seq_h.start(pulpino_spi_master_subsystem_env_h.pulpino_spi_master_subsystem_virtual_seqr_h); 
  phase.drop_objection(this);

endtask : run_phase

`endif
