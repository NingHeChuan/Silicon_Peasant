`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : .v
// Module Name  :
// Called By    :
// Abstract     :
//
// CopyRight(c) 2018, NingHeChuan Studio.. 
// All Rights Reserved
//
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 2018/12/14    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Binary2Gray
#(
    parameter   ADDR_SIZE   =   4
)
(
    input       [ADDR_SIZE:0]   bindata,
    output      [ADDR_SIZE-1:0] o_addr,
    output      [ADDR_SIZE:0]   adder_tr
);

wire    [ADDR_SIZE:0]   graydata;


assign  graydata = (bindata >> 1) ^ bindata;

assign  o_addr = bindata[ADDR_SIZE-1:0];
assign  adder_tr = graydata;

endmodule
