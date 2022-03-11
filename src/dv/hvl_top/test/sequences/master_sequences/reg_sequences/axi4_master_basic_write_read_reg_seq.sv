`ifndef AXI4_MASTER_BASIC_WRITE_READ_REG_SEQ_INCLUDE_
`define AXI4_MASTER_BASIC_WRITE_READ_REG_SEQ_INCLUDE_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_basic_write_read_reg_seq
// Extends the axi4_master_base_seq and randomises the req item
//--------------------------------------------------------------------------------------------
class axi4_master_basic_write_read_reg_seq extends axi4_master_reg_base_seq;
  `uvm_object_utils(axi4_master_basic_write_read_reg_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name ="axi4_master_basic_write_read_reg_seq");
  extern task body();
  endclass : axi4_master_basic_write_read_reg_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - axi4_master_basic_write_read_reg_seq
//--------------------------------------------------------------------------------------------
function axi4_master_basic_write_read_reg_seq::new(string name="axi4_master_basic_write_read_reg_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Task : body
// Creates the req of type master transaction and randomises the req.
//--------------------------------------------------------------------------------------------
task axi4_master_basic_write_read_reg_seq::body();
 // super.body();
  spi_master_apb_if spi_master_reg_block;
  uvm_reg_map spi_reg_map;

  uvm_status_e status;
  uvm_reg_data_t wdata;
  uvm_reg_data_t rdata;

  $cast(spi_master_reg_block, model);

  spi_reg_map = spi_master_reg_block.get_map_by_name("SPI_MASTER_MAP_ABP_IF");
  
  //-------------------------------------------------------
  // SPI LEN Register                                        
  //-------------------------------------------------------

  // Writing into the register
  begin

    bit [5:0] cmd_length;
    bit [5:0] addr_length;
    bit [15:0] data_length;
    cmd_length  = 6'h08;
    addr_length = 6'h08;
    data_length = 16'h20;

    `uvm_info(get_type_name(), $sformatf("Write :: Register cmd_length  = %0h",cmd_length) , UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register addr_length = %0h",addr_length), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register data_length = %0h",data_length), UVM_LOW)

    // Clearing and writing the required feilds
    wdata = (wdata & (~`MASK_SPILEN_DATALEN)) | (data_length << `POS_SPILEN_DATALEN) ;
    wdata = (wdata & (~`MASK_SPILEN_ADDRLEN)) | (addr_length << `POS_SPILEN_ADDRLEN);
    wdata = (wdata & (~`MASK_SPILEN_CMDLEN))  | (cmd_length << `POS_SPILEN_CMDLEN)  ;

    //setting the required feilds
    //wdata = wdata | (data_length << `POS_SPILEN_CMDLEN) | (addr_length << `POS_SPILEN_ADDRLEN) |
    //(cmd_length << `POS_SPILEN_CMDLEN);

  end

  //Writing into the SPI_LEN Register
  spi_master_reg_block.SPILEN.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("SPI_LEN_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.SPILEN.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the SPI_LEN Register
//  spi_master_reg_block.SPILEN.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("SPI_LEN_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.SPILEN.get_full_name(),rdata),UVM_HIGH)

  //-------------------------------------------------------
  // SPICMD
  //-------------------------------------------------------
  
  begin
    bit [31:0] spi_cmd;
    spi_cmd = 32'hffff_ffff;
    wdata = 0;
    wdata = (wdata & (~ `MASK_SPICMD_SPICMD)) | (spi_cmd << `POS_SPICMD_SPICMD);
  end

  //Writing into the SPICMD Register
  spi_master_reg_block.SPICMD.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("SPI_CMD_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.SPICMD.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the SPICMD Register
//  spi_master_reg_block.SPICMD.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("SPI_CMD_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.SPICMD.get_full_name(),rdata),UVM_HIGH)


  //-------------------------------------------------------
  // CLKDIV Register                                        
  //-------------------------------------------------------
  begin
    bit [7:0] clkdiv_value;
    clkdiv_value = 8'd1;
    wdata = 0;
    wdata = (wdata & (~ `MASK_CLKDIV_CLKDIV)) | (clkdiv_value << `POS_CLKDIV_CLKDIV);
  end

  //Writing into the Clockdiv Register
  spi_master_reg_block.CLKDIV.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("CLOCK_DIV_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.CLKDIV.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the Clockdiv Register
//  spi_master_reg_block.CLKDIV.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("CLOCK_DIV_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.CLKDIV.get_full_name(),rdata),UVM_HIGH)


  

 


  //-------------------------------------------------------
  // SPIADDR
  //-------------------------------------------------------
  
  begin
    bit [31:0] spi_adr;
    spi_adr = 32'hffff_ffff;
    wdata = 0;
    wdata = (wdata & (~ `MASK_SPIADR_SPIADR)) | (spi_adr << `POS_SPIADR_SPIADR);
  end
  
  //Writing into the SPI_ADDR Register
  spi_master_reg_block.SPIADR.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("SPI_ADDR_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.SPIADR.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the SPI_ADDR Register
//  spi_master_reg_block.SPIADR.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("SPI_ADDR_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.SPIADR.get_full_name(),rdata),UVM_HIGH)

 //-------------------------------------------------------
  // TX FIFO
  //-------------------------------------------------------
   begin

    bit [31:0] tx_fifo;

    tx_fifo = 32'hffff_f01a;

    `uvm_info(get_type_name(), $sformatf("Write :: Register tx_fifo = %0h",tx_fifo) , UVM_LOW)

    // Clearing the required bits
    wdata = (wdata & (~`MASK_TXFIFO_TX)) | (tx_fifo << `POS_TXFIFO_TX) ;
  
  end

  //Writing into the TX FIFO
  spi_master_reg_block.TXFIFO.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("TX_FIFO_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.TXFIFO.get_full_name(),wdata),UVM_HIGH)

 //-------------------------------------------------------
 // DUMMY REGISTER
 //-------------------------------------------------------
 //
 // Writing into the register
  begin

    bit [15:0] dummy_wr;
    bit [15:0]  dummy_rd;

    dummy_wr = 16'hffff;
    dummy_rd = 16'hffff;

    `uvm_info(get_type_name(), $sformatf("Write :: Register dummy_wr  = %0h",dummy_wr) , UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register dummy_rd = %0h",dummy_rd)  , UVM_LOW)

    // Clearing the required bits
    wdata = wdata & (~`MASK_SPIDUM_DUMMYWR) & (~`MASK_SPIDUM_DUMMYRD) ;

    //setting the required feilds
    //wdata = wdata | (dummy_wr << `POS_SPIDUM_DUMMYWR) | (dummy_rd << `POS_SPIDUM_DUMMYRD);

  end

 //Writing into the SPI_DUMMY Register
  spi_master_reg_block.SPIDUM.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("DUMMY_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.SPIDUM.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the SPI_DUMMY Register
//  spi_master_reg_block.SPIDUM.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("DUMMY_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.SPIDUM.get_full_name(),rdata),UVM_HIGH)

  
  

//  // Reading from the RX FIFO 
//  spi_master_reg_block.RXFIFO.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("RX_FIFO_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.RXFIFO.get_full_name(),rdata),UVM_HIGH)
 

  //-------------------------------------------------------
  // INTCFG Register                                        
  //-------------------------------------------------------

  // Writing into the register
  begin
    bit [4:0] thtx_value = 5'h1f ;
    bit [4:0] rhtx_value = 5'h1f ;
    bit [4:0] cnttx_value = 5'h4;
    bit [4:0] cntrx_value = 5'h4;

    `uvm_info(get_type_name(), $sformatf("Write :: Register thtx_value = %0h",thtx_value), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register rhtx_value = %0h",rhtx_value), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register cnttx_value = %0h",cnttx_value), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Write :: Register cntrx_value = %0h",cntrx_value), UVM_LOW)

    // Setting a value 
    wdata = (wdata & (~ `MASK_INTCFG_THTX))  | (thtx_value   << `POS_INTCFG_THTX);
    wdata = (wdata & (~ `MASK_INTCFG_RHTX))  | (rhtx_value   << `POS_INTCFG_RHTX);
    wdata = (wdata & (~ `MASK_INTCFG_CNTTX)) | (cnttx_value << `POS_INTCFG_CNTTX);
    wdata = (wdata & (~ `MASK_INTCFG_CNTRX)) | (cntrx_value << `POS_INTCFG_CNTRX);

    // Setting the required bits
    wdata = wdata | `MASK_INTCFG_CNTEN | `MASK_INTCFG_EN ; 

  end
 
  
  //Writing into the INTERUPT Register
  //wdata = 32'hDF1F_1F1F;
  spi_master_reg_block.INTCFG.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("INTERUPT_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s",
  spi_master_reg_block.INTCFG.get_full_name()),UVM_HIGH)

//  `uvm_info("INTERUPT_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.INTCFG.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the INTERUPT Register
//  spi_master_reg_block.INTCFG.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("INTERUPT_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.INTCFG.get_full_name(),rdata),UVM_HIGH)

  //-------------------------------------------------------
  // STATUS Register                                        
  //-------------------------------------------------------

  // Writing into the register
  begin
    bit [3:0] cs_value;
    cs_value = SLAVE_0;
    `uvm_info(get_type_name(), $sformatf("Write :: Register cs_value = %0b",cs_value), UVM_LOW)

    // Setting a value 
    wdata = (wdata & (~ `MASK_STATUS_CS)) | (cs_value << `POS_STATUS_CS);
    // Setting the required bits
    wdata = wdata | `MASK_STATUS_WR; 
    // Clearing the required bits
    wdata = wdata & (~`MASK_STATUS_QRD) & (~`MASK_STATUS_QWR) & (~`MASK_STATUS_RD) & (~ `MASK_STATUS_SRST);
  end

  spi_master_reg_block.STATUS.write(.status(status)      ,
                                    .value(wdata)        ,
                                    .path(UVM_FRONTDOOR) ,
                                    .map(spi_reg_map)    ,
                                    .parent(this)
                                  );                     

  `uvm_info("STATUS_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
  spi_master_reg_block.STATUS.get_full_name(),wdata),UVM_HIGH)

//  // Reading from the Status Register
//  spi_master_reg_block.STATUS.read(.status(status)       ,
//                                    .value(rdata)        ,
//                                    .path(UVM_FRONTDOOR) ,
//                                    .map(spi_reg_map)    ,
//                                    .parent(this)
//                                  );                     
//
//  `uvm_info("STATUS_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
//  spi_master_reg_block.STATUS.get_full_name(),rdata),UVM_HIGH)

//-------------------------------------------------------
// MSHA :: Commented section
//-------------------------------------------------------
// MSHA:  //super.body();
// MSHA:  spi_master_apb_if spi_master_reg_block;
// MSHA:   uvm_reg_map spi_reg_map;
// MSHA: 
// MSHA:   uvm_status_e status;
// MSHA:   uvm_reg_data_t wdata;
// MSHA:   uvm_reg_data_t rdata;
// MSHA: 
// MSHA:   $cast(spi_master_reg_block, model);
// MSHA: 
// MSHA:   spi_reg_map = spi_master_reg_block.get_map_by_name("SPI_MASTER_MAP_ABP_IF");
// MSHA: 
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // CLKDIV Register                                        
// MSHA:   //-------------------------------------------------------
// MSHA:   begin
// MSHA:     bit [7:0] clkdiv_value;
// MSHA:     clkdiv_value = 8'd1;
// MSHA:     wdata = 0;
// MSHA:     wdata = (wdata & (~ `MASK_CLKDIV_CLKDIV)) | (clkdiv_value << `POS_CLKDIV_CLKDIV);
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("CLOCK_DIV_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.CLKDIV.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the Clockdiv Register
// MSHA:   spi_master_reg_block.CLKDIV.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the Clockdiv Register
// MSHA: //  spi_master_reg_block.CLKDIV.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("CLOCK_DIV_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.CLKDIV.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // SPICMD
// MSHA:   //-------------------------------------------------------
// MSHA:   
// MSHA:   begin
// MSHA:     bit [31:0] spi_cmd;
// MSHA:     spi_cmd = 32'hffff_ffff;
// MSHA:     wdata = 0;
// MSHA:     wdata = (wdata & (~ `MASK_SPICMD_SPICMD)) | (spi_cmd << `POS_SPICMD_SPICMD);
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("SPI_CMD_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.SPICMD.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the SPICMD Register
// MSHA:   spi_master_reg_block.SPICMD.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the SPICMD Register
// MSHA: //  spi_master_reg_block.SPICMD.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("SPI_CMD_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.SPICMD.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // SPIADDR
// MSHA:   //-------------------------------------------------------
// MSHA:   
// MSHA:   begin
// MSHA:     bit [31:0] spi_adr;
// MSHA:     spi_adr = 32'hffff_ffff;
// MSHA:     wdata = 0;
// MSHA:     wdata = (wdata & (~ `MASK_SPIADR_SPIADR)) | (spi_adr << `POS_SPIADR_SPIADR);
// MSHA:   end
// MSHA:   
// MSHA:   `uvm_info("SPI_ADDR_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.SPIADR.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the SPI_ADDR Register
// MSHA:   spi_master_reg_block.SPIADR.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the SPI_ADDR Register
// MSHA: //  spi_master_reg_block.SPIADR.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("SPI_ADDR_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.SPIADR.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // SPI LEN Register                                        
// MSHA:   //-------------------------------------------------------
// MSHA: 
// MSHA:   // Writing into the register
// MSHA:   begin
// MSHA: 
// MSHA:     bit [5:0] cmd_length;
// MSHA:     bit [5:0] addr_length;
// MSHA:     bit [15:0] data_length;
// MSHA:     cmd_length  = 6'h8;
// MSHA:     addr_length = 6'h8;
// MSHA:     data_length = 16'h0020;
// MSHA: 
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register cmd_length  = %0h",cmd_length) , UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register addr_length = %0h",addr_length), UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register data_length = %0h",data_length), UVM_LOW)
// MSHA: 
// MSHA:     // Clearing and writing the required feilds
// MSHA:     wdata = (wdata & (~`MASK_SPILEN_DATALEN)) | (data_length << `POS_SPILEN_DATALEN) ;
// MSHA:     wdata = (wdata & (~`MASK_SPILEN_ADDRLEN)) | (addr_length << `POS_SPILEN_ADDRLEN) ;
// MSHA:     wdata = (wdata & (~`MASK_SPILEN_CMDLEN))  | (cmd_length << `POS_SPILEN_CMDLEN)   ;
// MSHA: 
// MSHA:     //setting the required feilds
// MSHA:     //wdata = wdata | (data_length << `POS_SPILEN_CMDLEN) | (addr_length << `POS_SPILEN_ADDRLEN) |
// MSHA:     //(cmd_length << `POS_SPILEN_CMDLEN);
// MSHA: 
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("SPI_LEN_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.SPILEN.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the SPI_LEN Register
// MSHA:   spi_master_reg_block.SPILEN.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the SPI_LEN Register
// MSHA: //  spi_master_reg_block.SPILEN.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("SPI_LEN_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.SPILEN.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA:  //-------------------------------------------------------
// MSHA:  // DUMMY REGISTER
// MSHA:  //-------------------------------------------------------
// MSHA:  //
// MSHA:  // Writing into the register
// MSHA:   begin
// MSHA: 
// MSHA:     bit [15:0] dummy_wr;
// MSHA:     bit [15:0]  dummy_rd;
// MSHA: 
// MSHA:     dummy_wr = 16'hffff;
// MSHA:     dummy_rd = 16'hffff;
// MSHA: 
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register dummy_wr  = %0h",dummy_wr) , UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register dummy_rd = %0h",dummy_rd)  , UVM_LOW)
// MSHA: 
// MSHA:     // Clearing the required bits
// MSHA:     wdata = wdata & (~`MASK_SPIDUM_DUMMYWR) & (~`MASK_SPIDUM_DUMMYRD) ;
// MSHA: 
// MSHA:     //setting the required feilds
// MSHA:     //wdata = wdata | (dummy_wr << `POS_SPIDUM_DUMMYWR) | (dummy_rd << `POS_SPIDUM_DUMMYRD);
// MSHA: 
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("DUMMY_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.SPIDUM.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:  //Writing into the SPI_DUMMY Register
// MSHA:   spi_master_reg_block.SPIDUM.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the SPI_DUMMY Register
// MSHA: //  spi_master_reg_block.SPIDUM.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("DUMMY_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.SPIDUM.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // TX FIFO
// MSHA:   //-------------------------------------------------------
// MSHA:    begin
// MSHA: 
// MSHA:     bit [31:0] tx_fifo;
// MSHA: 
// MSHA:     tx_fifo = 32'hffff_f01a;
// MSHA: 
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register tx_fifo = %0h",tx_fifo) , UVM_LOW)
// MSHA: 
// MSHA:     // Clearing the required bits
// MSHA:     wdata = (wdata & (~`MASK_TXFIFO_TX)) | (tx_fifo << `POS_TXFIFO_TX) ;
// MSHA:   
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("TX_FIFO_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.TXFIFO.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the TX FIFO
// MSHA:   spi_master_reg_block.TXFIFO.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // RX FIFO
// MSHA:   //-------------------------------------------------------
// MSHA:   //  begin
// MSHA:  
// MSHA:   //   bit [31:0] rx_fifo;
// MSHA:  
// MSHA:   //   rx_fifo = 32'hf011_1000;
// MSHA:  
// MSHA:   //   `uvm_info(get_type_name(), $sformatf("Write :: Register rx_fifo = %0h",rx_fifo) , UVM_LOW)
// MSHA:  
// MSHA:   //   // Clearing the required bits
// MSHA:   //   wdata = (wdata & (~`MASK_RXFIFO_RX)) | (rx_fifo << `POS_RXFIFO_RX) ;
// MSHA:   // 
// MSHA:   // end
// MSHA: 
// MSHA:   // MSHA: // Reading from the RX FIFO 
// MSHA:   // MSHA: spi_master_reg_block.RXFIFO.read(.status(status)       ,
// MSHA:   // MSHA:                                   .value(rdata)        ,
// MSHA:   // MSHA:                                   .path(UVM_FRONTDOOR) ,
// MSHA:   // MSHA:                                   .map(spi_reg_map)    ,
// MSHA:   // MSHA:                                   .parent(this)
// MSHA:   // MSHA:                                 );                     
// MSHA: 
// MSHA:   // MSHA: `uvm_info("RX_FIFO_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   // MSHA: spi_master_reg_block.RXFIFO.get_full_name(),rdata),UVM_HIGH)
// MSHA:  
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // INTCFG Register                                        
// MSHA:   //-------------------------------------------------------
// MSHA: 
// MSHA:   // Writing into the register
// MSHA:   begin
// MSHA:     bit [4:0] thtx_value = 5'h1f ;
// MSHA:     bit [4:0] rhtx_value = 5'h1f ;
// MSHA:     bit [4:0] cnttx_value = 5'h4;
// MSHA:     bit [4:0] cntrx_value = 5'h4;
// MSHA: 
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register thtx_value = %0h",thtx_value), UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register rhtx_value = %0h",rhtx_value), UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register cnttx_value = %0h",cnttx_value), UVM_LOW)
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register cntrx_value = %0h",cntrx_value), UVM_LOW)
// MSHA: 
// MSHA:     // Setting a value 
// MSHA:     wdata = (wdata & (~ `MASK_INTCFG_THTX))  | (thtx_value   << `POS_INTCFG_THTX);
// MSHA:     wdata = (wdata & (~ `MASK_INTCFG_RHTX))  | (rhtx_value   << `POS_INTCFG_RHTX);
// MSHA:     wdata = (wdata & (~ `MASK_INTCFG_CNTTX)) | (cnttx_value << `POS_INTCFG_CNTTX);
// MSHA:     wdata = (wdata & (~ `MASK_INTCFG_CNTRX)) | (cntrx_value << `POS_INTCFG_CNTRX);
// MSHA: 
// MSHA:     // Setting the required bits
// MSHA:     wdata = wdata | `MASK_INTCFG_CNTEN | `MASK_INTCFG_EN ; 
// MSHA: 
// MSHA:   end
// MSHA:  
// MSHA:   
// MSHA:   `uvm_info("INTERUPT_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.INTCFG.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   //Writing into the INTERUPT Register
// MSHA:   //wdata = 32'hDF1F_1F1F;
// MSHA:   spi_master_reg_block.INTCFG.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  `uvm_info("INTERUPT_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.INTCFG.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA: //  // Reading from the INTERUPT Register
// MSHA: //  spi_master_reg_block.INTCFG.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("INTERUPT_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.INTCFG.get_full_name(),rdata),UVM_HIGH)
// MSHA: 
// MSHA:   //-------------------------------------------------------
// MSHA:   // STATUS Register                                        
// MSHA:   //-------------------------------------------------------
// MSHA: 
// MSHA:   // Writing into the register
// MSHA:   begin
// MSHA:     bit [3:0] cs_value;
// MSHA:     cs_value = 4'b1;
// MSHA:     `uvm_info(get_type_name(), $sformatf("Write :: Register cs_value = %0b",cs_value), UVM_LOW)
// MSHA: 
// MSHA:     // Setting a value 
// MSHA:     wdata = (wdata & (~ `MASK_STATUS_CS)) | (cs_value << `POS_STATUS_CS);
// MSHA:     // Setting the required bits
// MSHA:     wdata = wdata | `MASK_STATUS_WR; 
// MSHA:     // Clearing the required bits
// MSHA:     wdata = wdata & (~`MASK_STATUS_QRD) & (~`MASK_STATUS_QWR)
// MSHA:                   & (~`MASK_STATUS_SRST) & (`MASK_STATUS_RD);
// MSHA:   end
// MSHA: 
// MSHA:   `uvm_info("STATUS_REG_SEQ",$sformatf("WRITE:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA:   spi_master_reg_block.STATUS.get_full_name(),wdata),UVM_HIGH)
// MSHA: 
// MSHA:   spi_master_reg_block.STATUS.write(.status(status)      ,
// MSHA:                                     .value(wdata)        ,
// MSHA:                                     .path(UVM_FRONTDOOR) ,
// MSHA:                                     .map(spi_reg_map)    ,
// MSHA:                                     .parent(this)
// MSHA:                                   );                     
// MSHA: 
// MSHA: //  // Reading from the Status Register
// MSHA: //  spi_master_reg_block.STATUS.read(.status(status)       ,
// MSHA: //                                    .value(rdata)        ,
// MSHA: //                                    .path(UVM_FRONTDOOR) ,
// MSHA: //                                    .map(spi_reg_map)    ,
// MSHA: //                                    .parent(this)
// MSHA: //                                  );                     
// MSHA: //
// MSHA: //  `uvm_info("STATUS_REG_SEQ",$sformatf("READ:: REGISTER : %0s, DATA = 32'h%0h",
// MSHA: //  spi_master_reg_block.STATUS.get_full_name(),rdata),UVM_HIGH)
// MSHA:  
endtask : body

`endif
