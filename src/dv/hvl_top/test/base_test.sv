`ifndef BASE_TEST_INCLUDED_
`define BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: base_test
// Base test has the testcase scenarios for the tesbench
// Env and Config are created in base_test
// Sequences are created and started in the test
//--------------------------------------------------------------------------------------------
class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  //Variable : env_h
  //Declaring a handle for env
  env env_h;

  //Variable : env_cfg_h
  //Declaring a handle for env_cfg_h
  env_config env_cfg_h;

  // Variable: spi_master_reg_block
  // Registers block for spi master module
  spi_master_apb_if spi_master_reg_block;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setup_env_config();
  extern virtual function void setup_axi4_master_agent_config();
  extern virtual function void setup_spi_slave_agent_config();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function base_test::new(string name = "base_test",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates env and required configuarions
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  setup_env_config();
  env_h = env::type_id::create("env",this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function : setup_env_config
// It calls the master agent config setup and slave agent config steup functions
//--------------------------------------------------------------------------------------------
function void base_test::setup_env_config();
  env_cfg_h = env_config::type_id::create("env_cfg_h");
  env_cfg_h.no_of_spi_slaves  = 1;
  env_cfg_h.has_scoreboard    = 1;
  env_cfg_h.has_virtual_seqr  = 1;
  `uvm_info(get_type_name(),$sformatf("\nenv_CONFIG\n%s",env_cfg_h.sprint()),UVM_LOW);

  //setting up the configuration for master agent
  setup_axi4_master_agent_config();

  //Setting the master agent configuration into config_db
  uvm_config_db#(axi4_master_agent_config)::set(this,"*master_agent*","axi4_master_agent_config",env_cfg_h.axi4_master_agent_cfg_h);

  //Displaying the master agent configuration
  `uvm_info(get_type_name(),$sformatf("\naxi4_master_agent_CONFIG\n%s",env_cfg_h.axi4_master_agent_cfg_h.sprint()),UVM_LOW);

  setup_spi_slave_agent_config();

  uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg_h);
  //`uvm_info(get_type_name(),$sformatf("\nenv_CONFIG\n%s",env_cfg_h.sprint()),UVM_LOW);

  // Creation of RAL
  if(spi_master_reg_block == null) 
  begin
    uvm_reg::include_coverage("*",UVM_CVR_ALL);

    spi_master_reg_block = spi_master_apb_if::type_id::create("spi_master_reg_block");
    spi_master_reg_block.build();

    // Enables sampling of coverage
    void'(spi_master_reg_block.set_coverage(UVM_CVR_ALL));

    spi_master_reg_block.lock_model();
  end

  env_cfg_h.spi_master_reg_block = this.spi_master_reg_block;

endfunction : setup_env_config

//--------------------------------------------------------------------------------------------
// Function : setup_axi4_master_agent_config
// Sets the configurations to the corresponding variables in pulpino_spi_master_subsystem master agent config
// Creates the master agent config
// Sets pulpino_spi_master_subsystem master agent config into configdb 
//--------------------------------------------------------------------------------------------
function void base_test::setup_axi4_master_agent_config();

  env_cfg_h.axi4_master_agent_cfg_h = axi4_master_agent_config::type_id::create("axi4_master_agent_config");
  if(MASTER_AGENT_ACTIVE === 1) begin
    env_cfg_h.axi4_master_agent_cfg_h.is_active    = uvm_active_passive_enum'(UVM_ACTIVE);
  end
  else begin
    env_cfg_h.axi4_master_agent_cfg_h.is_active    = uvm_active_passive_enum'(UVM_PASSIVE);
  end
  env_cfg_h.no_of_spi_slaves   = 1;
  env_cfg_h.axi4_master_agent_cfg_h.has_coverage   = 1;


endfunction : setup_axi4_master_agent_config

//--------------------------------------------------------------------------------------------
// Function : setup_pulpino_spi_master_subsystem_slave_agent_config
// It calls the master agent config setup and slave agent config steup functions
//--------------------------------------------------------------------------------------------
function void base_test::setup_spi_slave_agent_config();

  env_cfg_h.spi_slave_agent_cfg_h = new[env_cfg_h.no_of_spi_slaves];
  
  foreach(env_cfg_h.spi_slave_agent_cfg_h[i]) begin
    env_cfg_h.spi_slave_agent_cfg_h[i] = spi_slave_agent_config::type_id::create($sformatf("slave_agent_config[%0d]",i));
    env_cfg_h.spi_slave_agent_cfg_h[i].slave_id     = i;
    env_cfg_h.spi_slave_agent_cfg_h[i].is_active    = uvm_active_passive_enum'(UVM_ACTIVE);
    env_cfg_h.spi_slave_agent_cfg_h[i].spi_mode     = operation_modes_e'(CPOL0_CPHA1);
    env_cfg_h.spi_slave_agent_cfg_h[i].shift_dir    = shift_direction_e'(MSB_FIRST);
    env_cfg_h.spi_slave_agent_cfg_h[i].has_coverage = 1;
    env_cfg_h.spi_slave_agent_cfg_h[i].spi_type     = SIMPLE_SPI;

    uvm_config_db #(spi_slave_agent_config)::set(this,$sformatf("*spi_slave_agent_h[%0d]*",i),"spi_slave_agent_config", env_cfg_h.spi_slave_agent_cfg_h[i]);
   
    `uvm_info(get_type_name(),$sformatf("\npulpino_spi_master_subsystem_SLAVE_CONFIG[%0d]\n%s",i,env_cfg_h.spi_slave_agent_cfg_h[i].sprint()),UVM_LOW);
  end
endfunction : setup_spi_slave_agent_config


//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// Used to print topology
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void base_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
  uvm_test_done.set_drain_time(this,7000ns);
endfunction  : end_of_elaboration_phase


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give 100ns delay to complete the run_phase.
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this);

  super.run_phase(phase);

  #100;
  phase.drop_objection(this);

endtask : run_phase

`endif
