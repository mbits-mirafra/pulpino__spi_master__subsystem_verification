`ifndef PULPINO_SPI_MASTER_SUBSYSTEM_BASIC_READ_TEST_INCLUDED_
`define PULPINO_SPI_MASTER_SUBSYSTEM_BASIC_READ_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_8b_write_test
// Extends the base test and starts the virtual sequence
//--------------------------------------------------------------------------------------------
class pulpino_spi_master_subsystem_basic_read_test extends pulpino_spi_master_subsystem_base_test;
  `uvm_component_utils(pulpino_spi_master_subsystem_basic_read_test)
  
  //Variable :pulpino_spi_master_subsystem_virtual_basic_write_seq_h 
  //Instatiation of pulpino_spi_master_subsystem_virtual_basic_write_seq
  pulpino_spi_master_subsystem_virtual_basic_read_seq pulpino_spi_master_subsystem_virtual_basic_read_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "pulpino_spi_master_subsystem_basic_read_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : pulpino_spi_master_subsystem_basic_read_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - pulpino_spi_master_subsystem_basic_read_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function pulpino_spi_master_subsystem_basic_read_test::new(string name = "pulpino_spi_master_subsystem_basic_read_test",
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
task pulpino_spi_master_subsystem_basic_read_test::run_phase(uvm_phase phase);
  
  pulpino_spi_master_subsystem_virtual_basic_read_seq_h =
  pulpino_spi_master_subsystem_virtual_basic_read_seq::type_id::create("pulpino_spi_master_subsystem_virtual_basic_read_seq_h");

  `uvm_info(get_type_name(),$sformatf("pulpino_spi_master_subsystem_basic_read_test"),UVM_LOW);
  phase.raise_objection(this);
  pulpino_spi_master_subsystem_virtual_basic_read_seq_h.start(pulpino_spi_master_subsystem_env_h.pulpino_spi_master_subsystem_virtual_seqr_h); 
  phase.drop_objection(this);

endtask : run_phase

`endif
