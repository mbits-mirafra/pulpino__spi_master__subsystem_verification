`ifndef SCOREBOARD_INCLUDED_
`define SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: scoreboard
// Used to compare the data sent/received by the master with the slave's data sent/received
//--------------------------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  //Variable : axi4_data_packet
  //Handle for collector_packet_s struct
  collector_packet_s axi4_data_packet;

  //Variable : spi_slave_tx_h
  //Declaring handle for spi_slaver_tx
  spi_slave_tx spi_slave_tx_h;
  


  //Variable : axi4_master_write_address_analysis_fifo
  //Used to store the axi4_master_data
  uvm_tlm_analysis_fifo#(collector_packet_s) axi4_master_analysis_fifo;

  
  //Variable : spi_slave_analysis_fifo
  //Used to store the spi_slave_data
  uvm_tlm_analysis_fifo#(spi_slave_tx) spi_slave_analysis_fifo;

  //Variable : axi4_master_tx_count
  //to keep track of number of transactions for master 
  int axi4_master_tx_count = 0;

  //Variable : slave_tx_count
  //to keep track of number of transactions for slave 
  int spi_slave_tx_count = 0;

  //Variable byte_data_cmp_verified_master_awdata_slave_mosi_count
  //to keep track of number of byte wise compared verified master_tx_data
  int byte_data_cmp_verified_master_awdata_slave_mosi_count = 0;

  //Variable byte_data_cmp_failed_master_awdata_slave_mosi_count
  //to keep track of number of byte wise compared failed master_tx_data
  int byte_data_cmp_failed_master_awdata_slave_mosi_count = 0;

  int byte_data_cmp_verified_bit_count = 0;
  int byte_data_cmp_failed_bit_count   = 0;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

endclass : scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
// Initialization of new memory
//
// Parameters:
//  name - scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function scoreboard::new(string name = "scoreboard",
                                                      uvm_component parent = null);
  super.new(name, parent);
  axi4_master_analysis_fifo  = new("axi4_master_analysis_fifo",this);
  spi_slave_analysis_fifo                  = new("spi_slave_analysis_fifo",this);

endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Builds its parent components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the wdata and rdata are similar or not
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task scoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin

    bit [150:0]axi4_data;
    int        axi4_data_width;

    bit [150:0]spi_data;
    int        spi_data_width;
    
    `uvm_info(get_type_name(),$sformatf("before calling master's analysis fifo get method"),UVM_HIGH)
    axi4_master_analysis_fifo.get(axi4_data_packet);
    axi4_data = axi4_data_packet.data;
    axi4_data_width = axi4_data_packet.data_width;
    axi4_master_tx_count++;


    `uvm_info(get_type_name(),$sformatf("after calling master's analysis fifo get method"),UVM_HIGH) 
    `uvm_info(get_type_name(),$sformatf("printing axi4_data = %0h",axi4_data),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("before calling slave's analysis_fifo"),UVM_HIGH)

    spi_slave_analysis_fifo.get(spi_slave_tx_h);
    spi_slave_tx_count++;

    `uvm_info(get_type_name(),$sformatf("after calling slave's analysis fifo get method"),UVM_HIGH) 
    `uvm_info(get_type_name(),$sformatf("printing spi_slave_tx_h, \n %s",spi_slave_tx_h.sprint()),UVM_HIGH)


    foreach(spi_slave_tx_h.master_out_slave_in[i]) begin
      spi_data = {spi_data,spi_slave_tx_h.master_out_slave_in[i]};
      spi_data_width = spi_data_width + CHAR_LENGTH;
    end

    `uvm_info(get_type_name(),$sformatf("--\n-----------------------------------------------SCOREBOARD COMPARISIONS--------------------------------------------------"),UVM_HIGH)

    //Verifying awdata in master and slave 
    if(axi4_data == spi_data) begin
      `uvm_info(get_type_name(),$sformatf("axi4_awdata from axi4_master and master_out_slave_in from spi_slave is equal"),UVM_HIGH);
      `uvm_info("SB_axi4_DATA_MATCHED WITH MOSI0", $sformatf("Master axi4_DATA = 'h%0x and Slave SPI_DATA = 'h%0x",axi4_data,spi_data), UVM_HIGH); 

      byte_data_cmp_verified_master_awdata_slave_mosi_count++;
    end

    else begin
      `uvm_info(get_type_name(),$sformatf("axi4_awdata from axi4_master and master_out_slave_in from slave is not equal"),UVM_HIGH);
      `uvm_info("SB_axi4_DATA_MATCHED WITH MOSI0", $sformatf("Master axi4_DATA = 'h%0x and Slave SPI_DATA = 'h%0x",axi4_data,spi_data), UVM_HIGH); 
      byte_data_cmp_failed_master_awdata_slave_mosi_count++;
    end

    if(axi4_data_width == spi_data_width) begin
      `uvm_info(get_type_name(),$sformatf("Number of bits from axi4 packet and spi packet is equal"),UVM_HIGH);
      `uvm_info("NUMBER_OF_BITS_MATCHED",$sformatf("axi4_data_width=%0d,spi_data_width=%0d",axi4_data_width,spi_data_width),UVM_HIGH);
      byte_data_cmp_verified_bit_count++;
    end
    else begin
      `uvm_info(get_type_name(),$sformatf("Number of bits from axi4 packet and spi packet is not equal"),UVM_HIGH);
      `uvm_info("NUMBER_OF_BITS_NOT_MATCHED",$sformatf("axi4_data_width=%0d,spi_data_width=%0d",axi4_data_width,spi_data_width),UVM_HIGH);
      byte_data_cmp_failed_bit_count++;
    end

    `uvm_info(get_type_name(),$sformatf("--\n-----------------------------------------END OF SCOREBOARD COMPARISIONS--------------------------------------------------"),UVM_HIGH)
  end


endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);
 `uvm_info(get_type_name(),$sformatf (" Scoreboard Check Phase is Starting"),UVM_HIGH);
  `uvm_info("scoreboard",$sformatf("--\n------------------------------------------SCOREBOARD CHECK PHASE-----------------------------------------------"),UVM_HIGH);

  // Check if the comparisions counter is NON-zero
  // A non-zero value indicates that the comparisions never happened and throw error
  
  if (( byte_data_cmp_verified_master_awdata_slave_mosi_count!= 0)&&( byte_data_cmp_failed_master_awdata_slave_mosi_count== 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all mosi comparisions are succesful"),UVM_HIGH);
  end
  else begin
    if (( byte_data_cmp_verified_master_awdata_slave_mosi_count == 0) && ( byte_data_cmp_failed_master_awdata_slave_mosi_count== 0)) begin
      `uvm_error (get_type_name(), $sformatf ("comparisions of mosi not happened"));
    end
    `uvm_info (get_type_name(), $sformatf (" byte_data_cmp_verified_master_awdata_slave_mosi_count:%0d",
                                             byte_data_cmp_verified_master_awdata_slave_mosi_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf (" byte_data_cmp_failed_master_awdata_slave_mosi_count: %0d", 
                                             byte_data_cmp_failed_master_awdata_slave_mosi_count),UVM_HIGH);
  end
    
  if (( byte_data_cmp_verified_bit_count!= 0)&&( byte_data_cmp_failed_bit_count== 0)) begin
	  `uvm_info (get_type_name(), $sformatf ("all bit count comparisions are succesful"),UVM_HIGH);
  end
  else begin
    if (( byte_data_cmp_verified_bit_count == 0) && ( byte_data_cmp_failed_bit_count== 0)) begin
      `uvm_error (get_type_name(), $sformatf ("comparisions of mosi not happened"));
    end
    `uvm_info (get_type_name(), $sformatf (" byte_data_cmp_verified_bit_count:%0d",
                                             byte_data_cmp_verified_bit_count),UVM_HIGH);
	  `uvm_info (get_type_name(), $sformatf (" byte_data_cmp_failed_bit_count: %0d", 
                                             byte_data_cmp_failed_bit_count),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("comparisions of mosi not happened"));
  end

  //Check if axi4 master packets received are same as spi slave packets received
  // To Make sure that we have equal number of axi4 master and spi slave packets
  if (axi4_master_tx_count == spi_slave_tx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("master and slave have equal no. of transactions"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("axi4_master_tx_count : %0d",axi4_master_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("spi_slave_tx_count : %0d",spi_slave_tx_count ),UVM_HIGH);
    `uvm_error (get_type_name(), $sformatf ("axi4 master and spi slave doesnot have same no. of transactions"));
  end 
  
  //Analyis fifos must be zero - This will indicate that all the packets have been compared
  //This is to make sure that we have taken all packets from both FIFOs and made the
  //comparisions
   
  if (axi4_master_analysis_fifo.size() == 0)begin
     `uvm_info (get_type_name(), $sformatf ("axi4 master analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("axi4 master_analysis_fifo:%0d",axi4_master_analysis_fifo.size() ),UVM_HIGH);
     `uvm_error (get_type_name(), $sformatf ("axi4 master analysis FIFO is not empty"));
  end
  if (spi_slave_analysis_fifo.size()== 0)begin
     `uvm_info (get_type_name(), $sformatf ("Spi slave analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
     `uvm_info (get_type_name(), $sformatf ("spi slave_analysis_fifo:%0d",spi_slave_analysis_fifo.size()),UVM_HIGH);
     `uvm_error (get_type_name(),$sformatf ("Spi slave analysis FIFO is not empty"));
   end

  `uvm_info("scoreboard",$sformatf("--\n---------------------------------------END OF SCOREBOARD CHECK PHASE--------------------------------------------"),UVM_HIGH);

endfunction : check_phase
  
//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
 `uvm_info("scoreboard",$sformatf("--\n--------------------------------------------------SCOREBOARD REPORT-----------------------------------------------"),UVM_HIGH);

  `uvm_info (get_type_name(),$sformatf("Scoreboard Report Phase is Starting"),UVM_HIGH); 
  
  //Total number of packets received from the Master
  `uvm_info (get_type_name(),$sformatf("No. of transactions from master:%0d", axi4_master_tx_count),UVM_HIGH);

  //Total number of packets received from the Slave
  `uvm_info (get_type_name(),$sformatf("No. of transactions from slave:%0d", spi_slave_tx_count),UVM_HIGH);
  
  //Number of master_awdata comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte_data_cmp_verified_master_awdata_slave_mosi_count:%0d",
             byte_data_cmp_verified_master_awdata_slave_mosi_count),UVM_HIGH);

  //Number of master_awdata compariosn failed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte_data_cmp_failed_master_awdata_slave_mosi_count:%0d",
             byte_data_cmp_failed_master_awdata_slave_mosi_count),UVM_HIGH);

  //Number of master_bit_count comparisions passed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte_data_cmp_verified_bitcount:%0d",
             byte_data_cmp_verified_bit_count),UVM_HIGH);

  //Number of master_awdata compariosn failed
  `uvm_info (get_type_name(),$sformatf("Total no. of byte_data_cmp_failed_bit_count:%0d",
             byte_data_cmp_failed_bit_count),UVM_HIGH);

  `uvm_info("scoreboard",$sformatf("--\n--------------------------------------------------END OF SCOREBOARD REPORT-----------------------------------------------"),UVM_HIGH);


endfunction : report_phase

`endif

