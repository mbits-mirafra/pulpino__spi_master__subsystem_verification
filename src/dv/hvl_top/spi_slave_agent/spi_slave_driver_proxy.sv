`ifndef SPI_SLAVE_DRIVER_PROXY_INCLUDED_
`define SPI_SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: spi_slave_driver_proxy
//  This is the proxy driver on the HVL side
//  It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class spi_slave_driver_proxy extends uvm_driver#(spi_slave_tx);
  `uvm_component_utils(spi_slave_driver_proxy)
//  spi_slave_tx tx;

  // Variable: spi_slave_driver_bfm_h;
  // Handle for spi_slave driver bfm
  virtual spi_slave_driver_bfm spi_slave_drv_bfm_h;

  //  spi_slave_seq_item_converter  spi_slave_seq_item_conv_h;

  // Variable: spi_slave_agent_cfg_h;
  // Handle for spi_slave agent configuration
  spi_slave_agent_config spi_slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_bfm(inout spi_transfer_char_s packet, input spi_transfer_cfg_s struct_cfg);
  extern virtual function void reset_detected();

endclass : spi_slave_driver_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - spi_slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_slave_driver_proxy::new(string name = "spi_slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  spi_slave_driver_bfm congiguration is obtained in build phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(virtual spi_slave_driver_bfm)::get(this,"","spi_slave_driver_bfm",spi_slave_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_spi_slave_DRIVER_BFM","cannot get() spi_slave_drv_bfm_h");
  end

  //  spi_slave_seq_item_conv_h = spi_slave_seq_item_converter::type_id::create("spi_slave_seq_item_conv_h");
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connects driver_proxy and driver_bfm
//
//  Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void spi_slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
//  spi_slave_drv_bfm_h = spi_slave_agent_cfg_h.spi_slave_drv_bfm_h;
endfunction : connect_phase

//-------------------------------------------------------
//Function: end_of_elaboration_phase
//Description: connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//-------------------------------------------------------
function void spi_slave_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  spi_slave_drv_bfm_h.spi_slave_drv_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_slave_driver_proxy::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Gets the sequence_item, converts them to struct compatible transactions
// and sends them to the BFM to drive the data over the interface
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task spi_slave_driver_proxy::run_phase(uvm_phase phase);

  super.run_phase(phase);

  // Wait for system reset
  spi_slave_drv_bfm_h.wait_for_system_reset();

  // Wait for the IDLE state of SPI interface
  spi_slave_drv_bfm_h.wait_for_idle_state();

  // Driving logic
  forever begin
    spi_transfer_char_s struct_packet;
    spi_transfer_cfg_s struct_cfg;

    // Wait for transfer to start
    spi_slave_drv_bfm_h.wait_for_transfer_start();

    seq_item_port.get_next_item(req);
    `uvm_info(get_type_name(),$sformatf("Received packet from spi_slave sequencer : , \n %s",
                                        req.sprint()),UVM_HIGH)

    spi_slave_seq_item_converter::from_class(req, struct_packet); 
    spi_slave_cfg_converter::from_class(spi_slave_agent_cfg_h, struct_cfg); 

    `uvm_info("slave_proxy_debug",$sformatf("inside slave_driver_proxy"),UVM_HIGH)
    drive_to_bfm(struct_packet, struct_cfg);
    `uvm_info("slave_proxy_debug",$sformatf("outside slave_driver_proxy"),UVM_HIGH)

    spi_slave_seq_item_converter::to_class(struct_packet, req);
    `uvm_info(get_type_name(),$sformatf("Received packet from spi_slave DRIVER BFM : , \n %s",
                                        req.sprint()),UVM_LOW)

    seq_item_port.item_done();
  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: drive_to_bfm
// This task converts the transcation data packet to struct type and send
// it to the spi_slave_driver_bfm
//--------------------------------------------------------------------------------------------
task spi_slave_driver_proxy::drive_to_bfm(inout spi_transfer_char_s packet, input spi_transfer_cfg_s struct_cfg);

  // TODO(mshariff): Have a way to print the struct values
  // spi_slave_seq_item_converter::display_struct(packet);
  // string s;
  // s = spi_slave_seq_item_converter::display_struct(packet);
  // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);

//  case ({spi_slave_agent_cfg_h.spi_mode, spi_slave_agent_cfg_h.shift_dir})

   // {CPOL0_CPHA0,MSB_FIRST}: spi_slave_drv_bfm_h.drive_the_miso_data(packet,struct_cfg);
  
   `uvm_info(get_type_name(),$sformatf("Before DRIVING DATA TO DRIVER BFM STRUCT DATA PACKET : , \n %p",
                                        packet),UVM_HIGH)
    
  spi_slave_drv_bfm_h.drive_the_miso_data(packet,struct_cfg);
  `uvm_info(get_type_name(),$sformatf("BFM STRUCT DATA : , \n %p",
                                        packet),UVM_MEDIUM)
  if(packet.no_of_miso_bits_transfer == packet.no_of_mosi_bits_transfer) begin
    `uvm_info("DEBUG_spi_slave_DRIVER_PROXY","MOSI AND MISO TRANSFER BITS SIZE IS SAME",UVM_HIGH)
  end
  else begin
    `uvm_info("DEBUG_spi_slave_DRIVER_PROXY","MOSI AND MISO TRANSFER SIZE IS DIFFERENT",UVM_HIGH)
  end


//  endcase

endtask: drive_to_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void spi_slave_driver_proxy::reset_detected();
  `uvm_info(get_type_name(), "System reset is detected", UVM_NONE);

  // TODO(mshariff): 
  // Clear the data queues and kill the required threads
endfunction: reset_detected

`endif

