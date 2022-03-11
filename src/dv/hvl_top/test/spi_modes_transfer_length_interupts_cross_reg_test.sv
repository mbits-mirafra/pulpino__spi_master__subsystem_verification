`ifndef SPI_MODES_TRANSFER_LENGTH_INTERUPTS_CROSS_REG_TEST_INCLUDED_
`define SPI_MODES_TRANSFER_LENGTH_INTERUPTS_CROSS_REG_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_modes_transfer_length_interupts_cross_reg_test
// <Description_here>
//--------------------------------------------------------------------------------------------
class spi_modes_transfer_length_interupts_cross_reg_test extends base_test;
  `uvm_component_utils(spi_modes_transfer_length_interupts_cross_reg_test)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_modes_transfer_length_interupts_cross_reg_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : spi_modes_transfer_length_interupts_cross_reg_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - spi_modes_transfer_length_interupts_cross_reg_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_modes_transfer_length_interupts_cross_reg_test::new(string name = "spi_modes_transfer_length_interupts_cross_reg_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_modes_transfer_length_interupts_cross_reg_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_modes_transfer_length_interupts_cross_reg_test::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_modes_transfer_length_interupts_cross_reg_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_modes_transfer_length_interupts_cross_reg_test::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task spi_modes_transfer_length_interupts_cross_reg_test::run_phase(uvm_phase phase);
  virtual_spi_modes_transfer_length_interupts_cross_reg_seq virtual_spi_modes_transfer_length_interupts_cross_reg_seq_h;
  virtual_spi_modes_transfer_length_interupts_cross_reg_seq_h = virtual_spi_modes_transfer_length_interupts_cross_reg_seq::type_id::create("virtual_spi_modes_transfer_length_interupts_cross_reg_seq_h");

  `uvm_info(get_type_name(),$sformatf("spi_modes_transfer_length_interupts_cross_reg_test"),UVM_LOW);

  phase.raise_objection(this);

  virtual_spi_modes_transfer_length_interupts_cross_reg_seq_h.start(env_h.virtual_seqr_h); 

  phase.drop_objection(this);

endtask : run_phase

`endif
