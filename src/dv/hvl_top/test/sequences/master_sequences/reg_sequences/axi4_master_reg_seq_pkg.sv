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

  `include "axi4_master_std_mode_write_0_cmd_0_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_0_cmd_0_addr_16_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_0_cmd_16_addr_16_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_16_cmd_16_addr_16_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_8_cmd_8_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_8_cmd_16_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_8_cmd_32_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_16_cmd_16_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_0_cmd_32_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_32_cmd_32_addr_32_data_length_reg_seq.sv"
  `include "axi4_master_std_mode_write_even_clkdiv_reg_seq.sv"

  `include "axi4_master_spi_modes_clkdiv_dummy_cycles_cross_reg_seq.sv"
  `include "axi4_master_spi_modes_transfer_length_interupts_cross_reg_seq.sv"

  //`include "axi4_master_rand_reg_seq.sv"

  `include "axi4_master_negitive_reg_seq.sv"

endpackage : axi4_reg_seq_pkg

`endif
