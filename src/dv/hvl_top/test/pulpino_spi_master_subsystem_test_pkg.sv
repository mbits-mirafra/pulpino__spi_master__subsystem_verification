`ifndef PULPINO_SPI_MASTER_SUBSYSTEM_TEST_PKG_INCLUDED_
`define PULPINO_SPI_MASTER_SUBSYSTEM_TEST_PKG_INCLUDED_

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
  import axi4_globals_pkg::*;
  import spi_globals_pkg::*;
  import axi4_master_pkg::*;
  import spi_slave_pkg::*;
  import env_pkg::*;
  import spi_master_uvm_pkg::*;
  import spi_master_defines_pkg::*;
  import axi4_master_seq_pkg::*;
  import spi_slave_seq_pkg::*;
  import pulpino_spi_master_subsystem_virtual_seq_pkg::*;
  
  //-------------------------------------------------------
  // Including the base_test files
  //-------------------------------------------------------

  `include "base_test.sv"
  `include "basic_write_read_reg_test.sv"
  `include "basic_write_reg_test.sv"
  //`include "pulpino_spi_master_subsystem_basic_read_test.sv"
  `include "axi4_simple_reg_test.sv"
  `include "std_mode_write_0_cmd_0_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_0_cmd_0_addr_16_data_length_reg_test.sv"
  `include "std_mode_write_0_cmd_16_addr_16_data_length_reg_test.sv"
  `include "std_mode_write_16_cmd_16_addr_16_data_length_reg_test.sv"
  `include "std_mode_write_8_cmd_8_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_8_cmd_32_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_16_cmd_16_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_8_cmd_16_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_0_cmd_32_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_32_cmd_32_addr_32_data_length_reg_test.sv"
  `include "std_mode_write_even_clkdiv_reg_test.sv"
  `include "std_mode_write_tx_fifo_reg_test.sv"
 
  `include "spi_modes_clkdiv_dummy_cycles_cross_reg_test.sv"
  `include "spi_modes_transfer_length_interupts_cross_reg_test.sv"

  `include "rand_reg_test.sv"

  `include "negitive_reg_test.sv"

endpackage : pulpino_spi_master_subsystem_test_pkg

`endif
