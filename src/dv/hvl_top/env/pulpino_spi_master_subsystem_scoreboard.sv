`ifndef PULPINO_SPI_MASTER_SUBSYSTEM_SCOREBOARD_INCLUDED_
`define PULPINO_SPI_MASTER_SUBSYSTEM_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: pulpino_spi_master_subsystem_scoreboard
// Used to compare the data sent/received by the master with the slave's data sent/received
//--------------------------------------------------------------------------------------------
class pulpino_spi_master_subsystem_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(pulpino_spi_master_subsystem_scoreboard)

  //Variable : axi4_data_packet
  //Handle for collector_packet_s struct
  collector_packet_s axi4_data_packet;

  //Variable : spi_slave_tx_h
  //Declaring handle for spi_slaver_tx
  spi_slave_tx spi_slave_tx_h;
  
  //Variable : axi4_master_read_address_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_read_address_analysis_fifo;

  //Variable : axi4_master_read_data_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_read_data_analysis_fifo;

  //Variable : axi4_master_write_address_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_write_address_analysis_fifo;

  //Variable : axi4_master_write_data_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_write_data_analysis_fifo;
  
  //Variable : axi4_master_write_response_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_write_response_analysis_fifo;
  
  //Variable : spi_slave_analysis_fifo
  //Used to store the spi_slave_data
  uvm_tlm_analysis_fifo#(spi_slave_tx) spi_slave_analysis_fifo;

  //Variable : axi4_master_tx_count
  //to keep track of number of transactions for master 
  int axi4_master_tx_count = 0;

  //Variable : slave_tx_count
  //to keep track of number of transactions for slave 
  int spi_slave_tx_count = 0;

  //Variable byte_data_cmp_verified_master_pwdata_slave_mosi_count
  //to keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_pwdata_slave_mosi_count = 0;

  //Variable byte_data_cmp_failed_master_pwdata_slave_mosi_count
  //to keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_pwdata_slave_mosi_count = 0;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "pulpino_spi_master_subsystem_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

endclass : pulpino_spi_master_subsystem_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
// Initialization of new memory
//
// Parameters:
//  name - pulpino_spi_master_subsystem_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function pulpino_spi_master_subsystem_scoreboard::new(string name = "pulpino_spi_master_subsystem_scoreboard",
                                                      uvm_component parent = null);
  super.new(name, parent);
  axi4_master_write_address_analysis_fifo  = new("axi4_master_write_address_analysis_fifo",this);
  axi4_master_write_data_analysis_fifo     = new("axi4_master_write_data_analysis_fifo",this);
  axi4_master_write_response_analysis_fifo = new("axi4_master_write_response_analysis_fifo",this);
  axi4_master_read_address_analysis_fifo   = new("axi4_master_read_address_analysis_fifo",this);
  axi4_master_read_data_analysis_fifo      = new("axi4_master_read_data_analysis_fifo",this);
  spi_slave_analysis_fifo                  = new("spi_slave_analysis_fifo",this);

endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds its parent components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void pulpino_spi_master_subsystem_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task pulpino_spi_master_subsystem_scoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void pulpino_spi_master_subsystem_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);
endfunction : check_phase
  
//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void pulpino_spi_master_subsystem_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
endfunction : report_phase

`endif

