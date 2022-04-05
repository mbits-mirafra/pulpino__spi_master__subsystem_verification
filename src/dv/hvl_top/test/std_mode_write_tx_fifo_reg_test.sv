`ifndef STD_MODE_WRITE_TX_FIFO_REG_TEST_INCLUDED_
`define STD_MODE_WRITE_TX_FIFO_REG_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: apb_8b_write_test
// Extends the base test and starts the virtual sequence
//--------------------------------------------------------------------------------------------
class std_mode_write_tx_fifo_reg_test extends base_test;
  `uvm_component_utils(std_mode_write_tx_fifo_reg_test)
  
  //Variable :virtual_std_mode_write_tx_fifo_reg_seq_h 
  //Instatiation of virtual_std_mode_write_tx_fifo_reg_seq
  virtual_std_mode_write_tx_fifo_reg_seq virtual_std_mode_write_tx_fifo_reg_seq_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "std_mode_write_tx_fifo_reg_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : std_mode_write_tx_fifo_reg_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - std_mode_write_tx_fifo_reg_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function std_mode_write_tx_fifo_reg_test::new(string name = "std_mode_write_tx_fifo_reg_test",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Creates the apb_virtual_8b_seq sequnce and starts the 8b virtual sequences
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task std_mode_write_tx_fifo_reg_test::run_phase(uvm_phase phase);
  
  virtual_std_mode_write_tx_fifo_reg_seq_h = virtual_std_mode_write_tx_fifo_reg_seq::type_id::create("virtual_std_mode_write_tx_fifo_reg_seq_h");

  `uvm_info(get_type_name(),$sformatf("std_mode_write_tx_fifo_reg_test"),UVM_LOW);
  phase.raise_objection(this);
  virtual_std_mode_write_tx_fifo_reg_seq_h.start(env_h.virtual_seqr_h); 
  phase.drop_objection(this);

endtask : run_phase

`endif
