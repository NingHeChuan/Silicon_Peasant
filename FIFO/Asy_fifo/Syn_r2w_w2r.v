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

module Syn_r2w_w2r
#(
    parameter   ADDR_SIZE    =   4
)
(
    input           clk,
    input           rst_n,
    input   [ADDR_SIZE:0]  addr,
    output reg [ADDR_SIZE:0]  sy_addr
);

reg     [ADDR_SIZE:0]    addr_r;

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        {sy_addr, addr_r} <= 0;
    end
    else begin
        {sy_addr, addr_r} <= {addr_r, addr};
    end
end

endmodule
