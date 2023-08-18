///////////////////////////////////////////////////////
//     Copyright (c) 2009 Xilinx Inc.
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     :  12.1
//  \  \           Description : 
//  /  /                      
// /__/   /\       Filename    : CAPTUREE2.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Generated by :	/home/chen/xfoundry/HEAD/env/Databases/CAEInterfaces/LibraryWriters/bin/ltw.pl
//  Revision:		1.0
//     05/09/12 - removed GSR reference (CR 659430).
//    10/22/14 - Added #1 to $finish (CR 808642).
//     End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module CAPTUREE2 (
  CAP,
  CLK
);

  parameter ONESHOT = "TRUE";

  `ifdef XIL_TIMING

    parameter LOC = "UNPLACED";

  `endif


  input CAP;
  input CLK;

  reg [0:0] ONESHOT_BINARY;

  reg notifier;


  wire CAP_IN;
  wire CLK_IN;

  wire CAP_INDELAY;
  wire CLK_INDELAY;

  initial begin
    case (ONESHOT)
      "TRUE" : ONESHOT_BINARY = 1'b1;
      "FALSE" : ONESHOT_BINARY = 1'b0;
      default : begin
        $display("Attribute Syntax Error : The Attribute ONESHOT on CAPTUREE2 instance %m is set to %s.  Legal values for this attribute are TRUE, or FALSE.", ONESHOT);
        #1 $finish;
      end
    endcase

  end


  buf B_CAP (CAP_IN, CAP);
  buf B_CLK (CLK_IN, CLK);

  specify

  `ifdef XIL_TIMING
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (posedge CLK, negedge CAP, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CAP);
    $setuphold (posedge CLK, posedge CAP, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CAP);

  `endif //  `ifdef XIL_TIMING

    specparam PATHPULSE$ = 0;
  endspecify
endmodule

`endcelldefine
