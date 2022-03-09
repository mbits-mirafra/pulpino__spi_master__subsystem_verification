`ifndef AXI4_REG_SEQ_PKG_INCLUDED_
`define AXI4_REG_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : axi4_reg_seq_pkg
// Includes all the master register seq files declared
//--------------------------------------------------------------------------------------------
package axi4_reg_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import axi4_globals_pkg::*;
  import spi_globals_pkg::*;
  import uvm_pkg::*;
  import axi4_master_pkg::*;
  import spi_master_defines_pkg::*;
  import spi_master_uvm_pkg::*;
  
  //-------------------------------------------------------
  // Including required axi4 master seq files
  //-------------------------------------------------------
  `include "spi_master_defines.svh"

  `include "axi4_master_reg_base_seq.sv"
  `include "axi4_master_basic_write_read_reg_seq.sv"

endpackage : axi4_reg_seq_pkg

`endif
