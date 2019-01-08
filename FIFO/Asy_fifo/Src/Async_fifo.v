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

module Async_fifo
#(
    parameter   DATA_SIZE   =   8,
    parameter   ADDR_SIZE   =   4
)
(
    input               rst_n,
    //wr signal
    input               wclk,        
    input               wr_en,
    input   [DATA_SIZE-1:0] wr_data,
    //rd signal 
    input               rclk,
    input               rd_en,
    output  [DATA_SIZE-1:0] rd_data,
    //fifo signal 
    output   reg        fifo_full,
    output   reg        fifo_empty
);

localparam  DATA_DEPTH = 1 << (ADDR_SIZE+1);

reg     [ADDR_SIZE:0]   wr_cnt;
reg     [ADDR_SIZE:0]   rd_cnt;
wire    [ADDR_SIZE-1:0] wr_addr;
wire    [ADDR_SIZE:0]   wr_adder_tr;
wire    [ADDR_SIZE-1:0] rd_addr;
wire    [ADDR_SIZE:0]   rd_adder_tr;
//
wire    [ADDR_SIZE:0]   wr_sy_addr;
wire    [ADDR_SIZE:0]   rd_sy_addr;
//
wire    full_val;
wire    empty_val;

//-------------------------------------------------------
always @(posedge wclk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        wr_cnt <= 0;
    end
    else if(full_val == 1'b1)
        wr_cnt <= wr_cnt;
    else if(wr_cnt == DATA_DEPTH-1)
        wr_cnt <= 0;
    else if(wr_en && !fifo_full)begin
        wr_cnt <= wr_cnt + 1;
    end
    else 
        wr_cnt <= wr_cnt;
end

always @(posedge rclk or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        rd_cnt <= 0;
    end
    else if(empty_val == 1'b1)
        rd_cnt <= rd_cnt;
    else if(rd_cnt == DATA_DEPTH-1)
        rd_cnt <= 0;
    else if(rd_en && !fifo_empty)begin
        rd_cnt <= rd_cnt + 1;
    end
    else 
        rd_cnt <= rd_cnt;
end


 Binary2Gray
#(
    .ADDR_SIZE(ADDR_SIZE)
)
wr_Binary2Gray_inst(
    .bindata        (wr_cnt),
    .o_addr         (wr_addr),
    .adder_tr       (wr_adder_tr)
);


 Binary2Gray
#(
    .ADDR_SIZE(ADDR_SIZE)
)
rd_Binary2Gray_inst(
    .bindata        (rd_cnt),
    .o_addr         (rd_addr),
    .adder_tr       (rd_adder_tr)
);

//-------------------------------------------------------

Syn_r2w_w2r
#(
   .ADDR_SIZE(ADDR_SIZE)
)
Syn_w2r_inst(
    .clk            (rclk),
    .rst_n          (rst_n),
    .addr           (wr_adder_tr),
    .sy_addr        (wr_sy_addr)
);


Syn_r2w_w2r
#(
    .ADDR_SIZE(ADDR_SIZE)
)
Syn_r2w_inst(
    .clk            (wclk),
    .rst_n          (rst_n),
    .addr           (rd_adder_tr),
    .sy_addr        (rd_sy_addr)
);


fifo_mem
#(
    .DATA_SIZE(DATA_SIZE),
    .ADDR_SIZE(ADDR_SIZE)
)
fifo_mem_inst(
    .wclk           (wclk      ),
    .rclk           (rclk      ),
    .rst_n          (rst_n     ),
    .wr_en          (wr_en     ),
    .rd_en          (rd_en     ),
    .wr_data        (wr_data   ),
    .wr_addr        (wr_addr   ),
    .rd_addr        (rd_addr   ),
    .fifo_full      (fifo_full ),
    .fifo_empty     (fifo_empty),
    .rd_data        (rd_data   )
);

//-------------------------------------------------------
//empty

assign	empty_val = (rd_adder_tr == wr_sy_addr);

always @(posedge rclk or negedge rst_n)begin
    if(!rst_n) 
        fifo_empty <= 0;
    else 
        fifo_empty <= empty_val;    
end

//assign 	full_val = ((wr_cnt[ADDR_SIZE] != rd_cnt_r[ADDR_SIZE]) &&
//                     (wr_cnt[ADDR_SIZE-1] != rd_cnt_r[ADDR_SIZE-1]) &&
//                     (wr_cnt[ADDR_SIZE-2:0] == rd_cnt_r[ADDR_SIZE-2:0]));

//-------------------------------------------------------
//full

assign 	full_val = (wr_adder_tr == {~rd_sy_addr[ADDR_SIZE: ADDR_SIZE-1], rd_sy_addr[ADDR_SIZE-2:0]});

always @(posedge wclk or negedge rst_n)begin
    if(!rst_n)
        fifo_full <= 0;
    else
        fifo_full <= full_val;    
end

endmodule 
