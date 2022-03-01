// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

//`include "apb_bus.sv"

// SOC PERIPHERALS APB BUS PARAMETRES
`define NB_MASTER  9

// MASTER PORT TO CVP
`define UART_START_ADDR       32'h1A10_0000
`define UART_END_ADDR         32'h1A10_0FFF

// MASTER PORT TO GPIO
`define GPIO_START_ADDR       32'h1A10_1000
`define GPIO_END_ADDR         32'h1A10_1FFF

// MASTER PORT TO SPI MASTER
`define SPI_START_ADDR        32'h1A10_2000
`define SPI_END_ADDR          32'h1A10_2FFF

// MASTER PORT TO TIMER
`define TIMER_START_ADDR      32'h1A10_3000
`define TIMER_END_ADDR        32'h1A10_3FFF

// MASTER PORT TO EVENT UNIT
`define EVENT_UNIT_START_ADDR 32'h1A10_4000
`define EVENT_UNIT_END_ADDR   32'h1A10_4FFF

// MASTER PORT TO I2C
`define I2C_START_ADDR        32'h1A10_5000
`define I2C_END_ADDR          32'h1A10_5FFF

// MASTER PORT TO FLL
`define FLL_START_ADDR        32'h1A10_6000
`define FLL_END_ADDR          32'h1A10_6FFF

// MASTER PORT TO SOC CTRL
`define SOC_CTRL_START_ADDR   32'h1A10_7000
`define SOC_CTRL_END_ADDR     32'h1A10_7FFF

// MASTER PORT TO DEBUG
`define DEBUG_START_ADDR      32'h1A11_0000
`define DEBUG_END_ADDR        32'h1A11_7FFF

`define APB_ASSIGN_SLAVE(lhs, rhs)     \
    assign lhs.paddr    = rhs.paddr;   \
    assign lhs.pwdata   = rhs.pwdata;  \
    assign lhs.pwrite   = rhs.pwrite;  \
    assign lhs.psel     = rhs.psel;    \
    assign lhs.penable  = rhs.penable; \
    assign rhs.prdata   = lhs.prdata;  \
    assign rhs.pready   = lhs.pready;  \
    assign rhs.pslverr  = lhs.pslverr;

`define APB_ASSIGN_MASTER(lhs, rhs) `APB_ASSIGN_SLAVE(rhs, lhs)

module periph_bus_wrap
  #(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
    )
   (

    input logic       clk_i,
    input logic       rst_ni,

    APB_BUS.Slave     apb_slave,

    APB_BUS.Master    uart_master,
    APB_BUS.Master    gpio_master,
    APB_BUS.Master    spi_master,
    APB_BUS.Master    timer_master,
    APB_BUS.Master    event_unit_master,
    APB_BUS.Master    i2c_master,
    APB_BUS.Master    fll_master,
    APB_BUS.Master    soc_ctrl_master,
    APB_BUS.Master    debug_master

    );

  localparam NB_MASTER      = `NB_MASTER;

  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_start_addr;
  logic [NB_MASTER-1:0][APB_ADDR_WIDTH-1:0] s_end_addr;

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_masters[NB_MASTER-1:0]();

  APB_BUS
    #(
      .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
      .APB_DATA_WIDTH(APB_DATA_WIDTH)
      )
  s_slave();

  `APB_ASSIGN_SLAVE(s_slave, apb_slave);

  `APB_ASSIGN_MASTER(s_masters[0], uart_master);
  assign s_start_addr[0] = `UART_START_ADDR;
  assign s_end_addr[0]   = `UART_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[1], gpio_master);
  assign s_start_addr[1] = `GPIO_START_ADDR;
  assign s_end_addr[1]   = `GPIO_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[2], spi_master);
  assign s_start_addr[2] = `SPI_START_ADDR;
  assign s_end_addr[2]   = `SPI_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[3], timer_master);
  assign s_start_addr[3] = `TIMER_START_ADDR;
  assign s_end_addr[3]   = `TIMER_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[4], event_unit_master);
  assign s_start_addr[4] = `EVENT_UNIT_START_ADDR;
  assign s_end_addr[4]   = `EVENT_UNIT_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[5], i2c_master);
  assign s_start_addr[5] = `I2C_START_ADDR;
  assign s_end_addr[5]   = `I2C_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[6], fll_master);
  assign s_start_addr[6] = `FLL_START_ADDR;
  assign s_end_addr[6]   = `FLL_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[7], soc_ctrl_master);
  assign s_start_addr[7] = `SOC_CTRL_START_ADDR;
  assign s_end_addr[7]   = `SOC_CTRL_END_ADDR;

  `APB_ASSIGN_MASTER(s_masters[8], debug_master);
  assign s_start_addr[8] = `DEBUG_START_ADDR;
  assign s_end_addr[8]   = `DEBUG_END_ADDR;

  //********************************************************
  //**************** SOC BUS *******************************
  //********************************************************

  apb_node_wrap
  #(
    .NB_MASTER      ( NB_MASTER      ),
    .APB_ADDR_WIDTH ( APB_ADDR_WIDTH ),
    .APB_DATA_WIDTH ( APB_DATA_WIDTH )
  )
  apb_node_wrap_i
  (
    .clk_i        ( clk_i        ),
    .rst_ni       ( rst_ni       ),

    .apb_slave    ( s_slave      ),
    .apb_masters  ( s_masters    ),

    .start_addr_i ( s_start_addr ),
    .end_addr_i   ( s_end_addr   )
  );

endmodule
