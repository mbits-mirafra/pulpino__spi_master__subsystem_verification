`ifndef SUBSYSTEM_TOP_INCLUDED_
`define SUBSYSTEM_TOP_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module: subsystem_top
// This is a subsystem module which comprises of
// AXI2APB bridge <---> APB interconnect <---> APB_SPI master
//--------------------------------------------------------------------------------------------
module subsystem_top (
                      input logic clk,
                      input logic reset_n,

                      AXI_BUS.Slave axi_slave,

                      output logic       spi_master_clk,
                      output logic       spi_master_csn0,
                      output logic       spi_master_csn1,
                      output logic       spi_master_csn2,
                      output logic       spi_master_csn3,
                      output logic [1:0] spi_master_mode,
                      output logic       spi_master_sdo0,
                      output logic       spi_master_sdo1,
                      output logic       spi_master_sdo2,
                      output logic       spi_master_sdo3,
                      input  logic       spi_master_sdi0,
                      input  logic       spi_master_sdi1,
                      input  logic       spi_master_sdi2,
                      input  logic       spi_master_sdi3
                    );


  //-------------------------------------------------------
  // AXI2APB Bridge instantiation                      
  //-------------------------------------------------------
  APB_BUS s_apb_bus();
  
  axi2apb_wrap AXI2APB_BRIDGE (
      .clk_i      (clk),
      .rst_ni     (reset_n),
      .test_en_i  (1'b0),

      .axi_slave  (axi_slave),

      .apb_master (s_apb_bus)
    );
  
  //-------------------------------------------------------
  // APB interconnect
  //-------------------------------------------------------
  APB_BUS s_uart_bus();
  APB_BUS s_gpio_bus();
  APB_BUS s_spi_bus();
  APB_BUS s_timer_bus();
  APB_BUS s_event_unit_bus();
  APB_BUS s_i2c_bus();
  APB_BUS s_fll_bus();
  APB_BUS s_soc_ctrl_bus();
  APB_BUS s_debug_bus();

  periph_bus_wrap APB_INTERCONNECT (
      .clk_i             (clk),
      .rst_ni            (reset_n),

      .apb_slave         (s_apb_bus),

      .uart_master       ( s_uart_bus       ),
      .gpio_master       ( s_gpio_bus       ),
      .spi_master        ( s_spi_bus        ),
      .timer_master      ( s_timer_bus      ),
      .event_unit_master ( s_event_unit_bus ),
      .i2c_master        ( s_i2c_bus        ),
      .fll_master        ( s_fll_bus        ),
      .soc_ctrl_master   ( s_soc_ctrl_bus   ),
      .debug_master      ( s_debug_bus      )
    );
      
  //-------------------------------------------------------
  // APB_SPI master 
  //-------------------------------------------------------
  apb_spi_master DUT
  (
     .HCLK            (clk),
     .HRESETn         (reset_n),

     .PADDR           (s_spi_bus.paddr   ),
     .PWDATA          (s_spi_bus.pwdata  ),
     .PWRITE          (s_spi_bus.pwrite  ),
     .PSEL            (s_spi_bus.psel    ),
     .PENABLE         (s_spi_bus.penable ),
     .PRDATA          (s_spi_bus.prdata  ),
     .PREADY          (s_spi_bus.pready  ),
     .PSLVERR         (s_spi_bus.pslverr ),

     .events_o        (),

     .spi_clk         ( spi_master_clk  ),
     .spi_csn0        ( spi_master_csn0 ),
     .spi_csn1        ( spi_master_csn1 ),
     .spi_csn2        ( spi_master_csn2 ),
     .spi_csn3        ( spi_master_csn3 ),
     .spi_mode        ( spi_master_mode ),
     .spi_sdo0        ( spi_master_sdo0 ),
     .spi_sdo1        ( spi_master_sdo1 ),
     .spi_sdo2        ( spi_master_sdo2 ),
     .spi_sdo3        ( spi_master_sdo3 ),
     .spi_sdi0        ( spi_master_sdi0 ),
     .spi_sdi1        ( spi_master_sdi1 ),
     .spi_sdi2        ( spi_master_sdi2 ),
     .spi_sdi3        ( spi_master_sdi3 )
     
    );

endmodule: subsystem_top
`endif
