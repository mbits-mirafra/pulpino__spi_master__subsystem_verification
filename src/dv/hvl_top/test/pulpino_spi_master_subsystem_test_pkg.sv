`ifndef PULPINO_SPI_MASTER_SUBSYSTEM_BASE_BASE_TEST_PKG_INCLUDED_
`define PULPINO_SPI_MASTER_SUBSYSTEM_BASE_BASE_TEST_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: pulpino_spi_master_subsystem_base base_test
// Descrsubsystemtion:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package pulpino_spi_master_subsystem_test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import axi4_global_pkg::*;
  import spi_global_pkg::*;
  import axi4_master_pkg::*;
  import spi_slave_pkg::*;
  import pulpino_spi_master_subsystem_env_pkg::*;
  import spi_master_uvm_pkg::*;
  import spi_master_defines_pkg::*;
  import axi4_master_seq_pkg::*;
  import spi_slave_seq_pkg::*;
  import pulpino_spi_master_subsystem_virtual_seq_pkg::*;
  
  //-------------------------------------------------------
  // Including the base_test files
  //-------------------------------------------------------
  `include "pulpino_spi_master_subsystem_base_test.sv"
 
endpackage : pulpino_spi_master_subsystem_test_pkg

`endif
