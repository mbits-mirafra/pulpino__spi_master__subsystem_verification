`ifndef AXI4_MASTER_SEQ_PKG_INCLUDED_
`define AXI4_MASTER_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : axi4_master_seq_pkg
// Includes all the master seq files declared
//--------------------------------------------------------------------------------------------
package axi4_master_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import axi4_master_global_pkg::*;
  import uvm_pkg::*;
  import axi4_master_pkg::*;

  //-------------------------------------------------------
  // Including required axi4 master seq files
  //-------------------------------------------------------
  `include "axi4_master_base_seq.sv"

endpackage : axi4_master_seq_pkg

`endif
