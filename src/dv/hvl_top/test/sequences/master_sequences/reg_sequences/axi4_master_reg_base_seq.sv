`ifndef AXI4_MASTER_REG_BASE_SEQ_INCLUDE_
`define AXI4_MASTER_REG_BASE_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_reg_base_seq
// Extends the axi4_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class axi4_master_reg_base_seq extends uvm_reg_sequence;

  `uvm_object_utils(axi4_master_reg_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="axi4_master_reg_base_seq");
  extern task body();
  endclass : axi4_master_reg_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_master_reg_base_seq
//--------------------------------------------------------------------------------------------
function axi4_master_reg_base_seq::new(string name="axi4_master_reg_base_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task axi4_master_reg_base_seq::body();

//  uvm_reg_map spi_reg_map; 
//
//  $cast(spi_master_reg_block, model);
//
//  spi_reg_map = spi_master_reg_block.get_map_by_name("SPI_MASTER_MAP_APB_IF");

endtask : body

`endif
