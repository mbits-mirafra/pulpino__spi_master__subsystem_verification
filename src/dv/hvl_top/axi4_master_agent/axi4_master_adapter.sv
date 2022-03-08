`ifndef AXI4_MASTER_ADAPTER_INCLUDED_
`define AXI4_MASTER_ADAPTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_adapter
// Converts register transactions to AXI transactions and vice-versa
//--------------------------------------------------------------------------------------------
class axi4_master_adapter extends uvm_reg_adapter;
  `uvm_object_utils(axi4_master_adapter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "axi4_master_adapter");
  extern function uvm_sequence_item reg2bus( const ref uvm_reg_bus_op rw );
  extern function void bus2reg( uvm_sequence_item bus_item,
                              ref uvm_reg_bus_op rw );
endclass : axi4_master_adapter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_master_adapter
//--------------------------------------------------------------------------------------------
function axi4_master_adapter::new(string name = "axi4_master_adapter");
  super.new(name);

  // Set default values for the two variables based on bus protocol
  // AXI does not support either, so both are turned off
  supports_byte_enable = 0;
  provides_responses   = 0;
endfunction : new

//--------------------------------------------------------------------------------------------
// Function : reg2bus
// Used for converting register sequences to axi bus transactions
//--------------------------------------------------------------------------------------------
function uvm_sequence_item axi4_master_adapter::reg2bus( const ref uvm_reg_bus_op rw );
  axi4_master_tx axi4_tx
            = axi4_master_tx::type_id::create("axi4_master_tx");

  if ( rw.kind == UVM_READ )
  begin
    axi4_tx.transfer_type =  NON_BLOCKING_READ;
    axi4_tx.arburst = READ_INCR;
    axi4_tx.araddr = rw.addr;
    axi4_tx.arsize = READ_8_BYTES;
    axi4_tx.tx_type = READ;
  end

  if ( rw.kind == UVM_WRITE ) 
  begin
    axi4_tx.transfer_type =  NON_BLOCKING_WRITE;
    axi4_tx.awburst = WRITE_INCR;
    foreach(rw.data[i]) begin
      axi4_tx.wdata[i] = rw.data[i];
    end
    axi4_tx.awaddr = rw.addr;
    axi4_tx.awsize =  WRITE_8_BYTES;
    axi4_tx.tx_type = WRITE;
  end

 
  // Assuming these address range falls in the slave0 domain
  // TODO(mshariff): Need to add more logic to be intelligent to pick correct pselx value
  // axi4_tx.pselx = SLAVE_0; 

  `uvm_info(get_type_name(), $sformatf("The converted reg2bus packet is %s\n",axi4_tx.sprint()), UVM_HIGH);

  return axi4_tx;
endfunction: reg2bus

//--------------------------------------------------------------------------------------------
// Function: bus2reg
// Used for converting apb bus transactions into register transactions
//--------------------------------------------------------------------------------------------
function void axi4_master_adapter::bus2reg( uvm_sequence_item bus_item,
                                          ref uvm_reg_bus_op rw );
  // MSHA:jelly_bean_transaction jb_tx;
  axi4_master_tx axi4_tx; 

  if ( ! $cast( axi4_tx, bus_item ) ) begin
     `uvm_fatal( get_name(),
                 "bus_item is not of the axi4_master_tx type." )
     return;
  end

  // Assuming these address range falls in the slave0 domain
  // TODO(mshariff): Need to add more logic to be intelligent to pick correct pselx value
 // axi4_tx.pselx = SLAVE_0; 

 // rw.kind = ( axi4_tx.tx_type == READ ) ? UVM_READ : UVM_WRITE;
 
  if(axi4_tx.tx_type == READ) begin
    rw.addr = axi4_tx.araddr;
    foreach(axi4_tx.rdata[i]) begin
      rw.data[i] = axi4_tx.rdata[i];
    end
    rw.status = UVM_IS_OK;
  end

  if(axi4_tx.tx_type == WRITE) begin
    rw.addr = axi4_tx.awaddr;
    foreach(axi4_tx.wdata[i]) begin
      rw.data[i] = axi4_tx.wdata[i];
    end
    rw.status = UVM_IS_OK;
  end

  `uvm_info(get_type_name(), $sformatf("The converted bus2reg packet is %s\n",axi4_tx.sprint()), UVM_HIGH);

endfunction: bus2reg

`endif
