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

module TB_Async_fifo;

    parameter   DATA_SIZE   =   8;
    parameter   ADDR_SIZE   =   4;
    parameter   DATA_DEPTH =    32;

    reg               rst_n;
    //wr signal
    reg               wclk;       
    reg               wr_en;
    reg   [DATA_SIZE-1:0] wr_data;
    //rd signal 
    reg               rclk;
    reg               rd_en;
    wire  [DATA_SIZE-1:0] rd_data;
    //fifo signal 
    wire              fifo_full;
    wire              fifo_empty;

Async_fifo
#(
    .DATA_SIZE(DATA_SIZE),
    .ADDR_SIZE(ADDR_SIZE)
)
Async_fifo_inst(
    .rst_n          (rst_n     ),
    .wclk           (wclk      ),        
    .wr_en          (wr_en     ),
    .wr_data        (wr_data   ),
    .rclk         (rclk    ),
    .rd_en          (rd_en     ),
    .rd_data        (rd_data   ),
    .fifo_full      (fifo_full ),
    .fifo_empty     (fifo_empty)
);

always #10 wclk = ~wclk;
always #20 rclk = ~rclk;

integer i;


always @(posedge wclk or negedge rst_n)begin
    if(!rst_n)
        wr_data <= 0;
    else if(fifo_full)
        wr_data <= wr_data;
    else 
        wr_data <= wr_data + 1;
end

always @(posedge wclk or negedge rst_n)begin
    if(!rst_n)
        wr_en <= 0;
    else if(wr_data >= 30)
        wr_en <= 0;
    else 
        wr_en <= 1;
end

always @(posedge rclk or negedge rst_n)begin
    if(!rst_n)
        rd_en <= 0;
    else if(fifo_empty)
        rd_en <= 0;
    else 
        rd_en <= 1;
end

initial begin
wclk = 0;
rclk = 0;
rst_n = 0;
//rd_en = 0;
//wr_en = 0;
//wr_data = 0;

#100
rst_n = 1;

/*
for(i = 0; i < DATA_DEPTH; i = i+1)begin
    wr_en = 1;
    wr_data = i;
    #20;
end
//wr_en = 0;

#1000
for(i = 0; i < DATA_DEPTH; i = i+1)begin
    rd_en = 1;
    #40;
end
//rd_en = 0;
*/
end

endmodule 
