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
// 2018/12/11    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Syn_fifo
#(
    parameter   DATA_WIDTH  =   8,
    parameter   ADDR_WIDTH  =   4,
    parameter   RAM_DEPTH   =   (1 << ADDR_WIDTH)
)
(
    input           clk,
    input           rst_n,
    input   [DATA_WIDTH-1:0]    data_in,
    input           wr_en,
    input           rd_en,
    output reg  [DATA_WIDTH-1:0]    data_out,
    output          empty,          //fifo empty
    output          full            //fifo full
);

reg     [ADDR_WIDTH-1:0]    wr_cnt;
reg     [ADDR_WIDTH-1:0]    rd_cnt;
reg     [ADDR_WIDTH-1:0]    status_cnt;
reg     [DATA_WIDTH-1:0]    data_ram;

//-------------------------------------------------------
assign  full = (status_cnt == (RAM_DEPTH-1))? 1'b1: 1'b0;
assign  empty = (status_cnt == 0)? 1'b1: 1'b0;


//Syn
reg     rd_en_r;
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        rd_en_r <= 0;
    end
    else begin
        rd_en_r <= rd_en;
    end
end


//-------------------------------------------------------
always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_cnt <= 0;
    end
    else if(wr_cnt == RAM_DEPTH-1)
        wr_cnt <= 0;
    else if(wr_en)begin
        wr_cnt <= wr_cnt + 1'b1;
    end
    else 
        wr_cnt <= wr_cnt;
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        rd_cnt <= 0;
    end
    else if(rd_cnt == RAM_DEPTH-1)
        rd_cnt <= 0;
    else if(rd_en)begin
        rd_cnt <= rd_cnt + 1'b1;
    end
    else 
        rd_cnt <= rd_cnt;
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        data_out <= 0;
    end
    else if(rd_en_r)begin
        data_out <= data_ram;
    end
end


always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        status_cnt <= 0;
    end
    else if(rd_en && !wr_en && (status_cnt != 0))begin
        status_cnt <= status_cnt - 1;
    end
    else if(wr_en && !rd_en && (status_cnt != RAM_DEPTH-1))
        status_cnt <= status_cnt + 1;
    else 
        status_cnt <= status_cnt;
end

//-------------------------------------------------------
//Syn_Dual_Port_RAM
integer     i;
reg     [DATA_WIDTH-1:0]   register[RAM_DEPTH-1:0];

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        for(i = 0; i < RAM_DEPTH; i = i + 1)
            register[i] <= 0;
    end
    else if(wr_en == 1'b1)
        register[wr_cnt] <= data_in;  
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        data_ram <= 0;
    end
    else if(rd_en == 1'b1)
        data_ram <= register[rd_cnt];
    else 
        data_ram <= data_ram;
end

endmodule
