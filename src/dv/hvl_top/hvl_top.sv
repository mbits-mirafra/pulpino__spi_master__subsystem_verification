`ifndef HVL_TOP_INCLUDED_
`define HVL_TOP_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module : hvl_top
// Starts the testbench components
//--------------------------------------------------------------------------------------------
module hvl_top;

  //-------------------------------------------------------
  // Package : Importing UVM Package and test Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  //import pulpino_spi_master_subsystem_test_pkg::*;

  //-------------------------------------------------------
  // calling run_test for simulation
  //-------------------------------------------------------
  initial begin
    run_test("pulpino_spi_master_subsystem_base_test");
  end

endmodule : hvl_top

`endif
