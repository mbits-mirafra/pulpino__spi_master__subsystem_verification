`ifndef ENV_PKG_INCLUDED_
`define ENV_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: env_pkg
// Includes all the files related to pulpino_spi_master_subsystem env
//--------------------------------------------------------------------------------------------
package env_pkg;
  
  //-------------------------------------------------------
  // Importing uvm packages
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import axi4_globals_pkg::*;
  import spi_globals_pkg::*;
  import pulpino_spi_master_subsystem_global_pkg::*;
  import axi4_master_pkg::*;
  import spi_slave_pkg::*;
  import spi_master_defines_pkg::*;
  import spi_master_uvm_pkg::*;

  //-------------------------------------------------------
  // Including the required files
  //-------------------------------------------------------
  `include "env_config.sv"
  `include "axi4_reg_predictor.sv"
  `include "virtual_sequencer.sv"
  `include "scoreboard.sv"
  `include "axi4_master_collector.sv"
  `include "spi_slave_collector.sv"
  `include "env.sv"

endpackage : env_pkg

`endif
