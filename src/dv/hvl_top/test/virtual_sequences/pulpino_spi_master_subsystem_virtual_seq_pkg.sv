`ifndef PULPINO_SPI_MASTER_SUBSYSTEM_VIRTUAL_SEQ_PKG_INCLUDED_
`define PULPINO_SPI_MASTER_SUBSYSTEM_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package : pulpino_spi_master_subsystem_virtual_seq_pkg
// Includes all the master seq files declared
//--------------------------------------------------------------------------------------------
package pulpino_spi_master_subsystem_virtual_seq_pkg;

  //-------------------------------------------------------
  // Importing UVM Pkg
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import axi4_master_pkg::*;
  import spi_slave_pkg::*;
  import axi4_master_seq_pkg::*;
  import spi_slave_seq_pkg::*;
  import pulpino_spi_master_subsystem_env_pkg::*;
  import axi4_reg_seq_pkg::*;

  //-------------------------------------------------------
  // Including required package files
  //-------------------------------------------------------
  `include "pulpino_spi_master_subsystem_virtual_base_seq.sv"
  
  // Register virtual sequences
  `include "virtual_reg_seq.sv"

endpackage : pulpino_spi_master_subsystem_virtual_seq_pkg

`endif
