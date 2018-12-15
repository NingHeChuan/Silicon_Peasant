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

module fifo_mem
#(
    parameter   DATA_SIZE = 8,
    parameter   ADDR_SIZE = 4
)
(
    input                   wclk,
    input                   rclk,
    input                   rst_n,
    input                   wr_en,
    input                   rd_en,
    input   [DATA_SIZE-1:0] wr_data,
    input   [ADDR_SIZE-1:0] wr_addr,
    input   [ADDR_SIZE-1:0] rd_addr,
    input                   fifo_full,
    input                   fifo_empty,
    output reg  [DATA_SIZE-1:0] rd_data
);

localparam  DATA_DEPTH = 1 << ADDR_SIZE;



//-------------------------------------------------------
//Syn_Dual_Port_RAM
integer     i;
reg     [DATA_SIZE-1:0]   register[DATA_DEPTH-1:0];

always @(posedge wclk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        for(i = 0; i < DATA_DEPTH; i = i + 1)
            register[i] <= 0;
    end
    else if(wr_en == 1'b1 && !fifo_full)
        register[wr_addr] <= wr_data;  
end

//assign  rd_data = register[rd_addr];

always @(posedge rclk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        rd_data <= 0;
    end
    else if(rd_en && !fifo_empty)
        rd_data <= register[rd_addr];
    else 
        rd_data <= rd_data;
end

endmodule 
