`ifndef BASIC_WRITE_READ_REG_TEST_INCLUDED_
`define BASIC_WRITE_READ_REG_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: basic_write_read_reg_test
// <Descrsubsystemtion_here>
//--------------------------------------------------------------------------------------------
class basic_write_read_reg_test extends base_test;
  `uvm_component_utils(basic_write_read_reg_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "basic_write_read_reg_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : basic_write_read_reg_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - basic_write_read_reg_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function basic_write_read_reg_test::new(string name = "basic_write_read_reg_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Descrsubsystemtion_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void basic_write_read_reg_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Descrsubsystemtion_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void basic_write_read_reg_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Descrsubsystemtion_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void basic_write_read_reg_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Descrsubsystemtion_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void basic_write_read_reg_test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Descrsubsystemtion_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task basic_write_read_reg_test::run_phase(uvm_phase phase);
  virtual_basic_write_read_reg_seq virtual_basic_write_read_reg_seq_h;
  virtual_basic_write_read_reg_seq_h = virtual_basic_write_read_reg_seq::type_id::create("virtual_basic_write_read_reg_seq_h");

  `uvm_info(get_type_name(),$sformatf("basic_write_read_reg_test"),UVM_LOW);

  phase.raise_objection(this);

  virtual_basic_write_read_reg_seq_h.start(pulpino_spi_master_subsystem_env_h.pulpino_spi_master_subsystem_virtual_seqr_h); 

  phase.drop_objection(this);

endtask : run_phase

`endif
