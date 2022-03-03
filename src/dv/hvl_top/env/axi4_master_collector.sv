`ifndef AXI4_MASTER_COLLECTOR_INCLUDED_
`define AXI4_MASTER_COLLECTOR_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_collector
// <Description_here>
//--------------------------------------------------------------------------------------------
class axi4_master_collector extends uvm_component;
  `uvm_component_utils(axi4_master_collector)

  uvm_analysis_port#(collector_packet_s) axi4_master_coll_analysis_port;
  uvm_analysis_imp#(axi4_master_tx, axi4_master_collector) axi4_master_coll_imp_port;

  uvm_reg_map map;

  collector_packet_s coll_pkt;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "axi4_master_collector", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void write(axi4_master_tx t);

endclass : axi4_master_collector

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_master_collector
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function axi4_master_collector::new(string name = "axi4_master_collector",
                                 uvm_component parent = null);
  super.new(name, parent);
  axi4_master_coll_analysis_port = new("axi4_master_coll_analysis_port",this);
  axi4_master_coll_imp_port = new("axi4_master_coll_imp_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Build phase is used to build the axi4_master collector component
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void axi4_master_collector::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function : write
// Parameters : 
// t  - axi4_master_tx
//--------------------------------------------------------------------------------------------
function void axi4_master_collector::write(axi4_master_tx t);

  `uvm_info(get_type_name(), $sformatf("rg_name = %0s", rg.get_name()),UVM_HIGH)

endfunction : write

`endif

