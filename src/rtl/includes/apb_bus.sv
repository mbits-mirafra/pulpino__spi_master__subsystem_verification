// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


`ifndef APB_BUS_SV
`define APB_BUS_SV

//`include "config.sv"
import config_pkg::*;

////////////////////////////////////////////////////////////////////////////////
//          Only general functions and definitions are defined here           //
//              These functions are not intended to be modified               //
////////////////////////////////////////////////////////////////////////////////

interface APB_BUS
#(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
);

    logic [APB_ADDR_WIDTH-1:0]                                        paddr;
    logic [APB_DATA_WIDTH-1:0]                                        pwdata;
    logic                                                             pwrite;
    logic                                                             psel;
    logic                                                             penable;
    logic [APB_DATA_WIDTH-1:0]                                        prdata;
    logic                                                             pready;
    logic                                                             pslverr;

   // Master Side
   //***************************************
   modport Master
   (
      output      paddr,  pwdata,  pwrite, psel,  penable,
      input       prdata,          pready,        pslverr
   );

   // Slave Side
   //***************************************
   modport Slave
   (
      input      paddr,  pwdata,  pwrite, psel,  penable,
      output     prdata,          pready,        pslverr
   );

endinterface

`endif
