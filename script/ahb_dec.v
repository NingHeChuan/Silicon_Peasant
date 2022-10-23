// +FHDR----------------------------------------------------------------------------
// Copyright (c) 2022 SiliconPeasant.
// ALL RIGHTS RESERVED Worldwide
//         
// Author        : parallels
// Email         : ninghechuan@foxmail.com
// Created On    : 2022/10/24 00:13
// Last Modified : 2022/10/24 00:13
// File Name     : ahb_dec.v
// Description   :
// 
// ---------------------------------------------------------------------------------
// Modification History:
// Date         By              Version                 Change Description
// ---------------------------------------------------------------------------------
// 2022/10/24   parallels     1.0                     Original
// -FHDR----------------------------------------------------------------------------
module ahb_dec(
    input                   hclk,
    input                   hresetn,
    //slave
    input                   ahb_s_hsel,
    input   [31:0]          ahb_s_haddr,
    input   [1:0]           ahb_s_htrans,
    input                   ahb_s_hwrite,
    input   [2:0]           ahb_s_hsize,
    input   [2:0]           ahb_s_hburst,
    input   [3:0]           ahb_s_hprot,
    input   [31:0]          ahb_s_hwdata,
    input                   ahb_s_hready_in,
    output reg  [31:0]      ahb_s_hrdata,
    output reg              ahb_s_hready,
    output reg  [1:0]       ahb_s_hresp,
    //M0
    output reg              ahb_m0_hsel,
    output reg [31:0]       ahb_m0_haddr,
    output reg [1:0]        ahb_m0_htrans,
    output reg              ahb_m0_hwrite,
    output reg [2:0]        ahb_m0_hsize,
    output reg [2:0]        ahb_m0_hburst,
    output reg [3:0]        ahb_m0_hprot,
    output reg [31:0]       ahb_m0_hwdata,
    output reg              ahb_m0_hready_in,
    input    [31:0]         ahb_m0_hrdata,
    input                   ahb_m0_hready,
    input    [1:0]          ahb_m0_hresp,
    //M1
    output reg              ahb_m1_hsel,
    output reg [31:0]       ahb_m1_haddr,
    output reg [1:0]        ahb_m1_htrans,
    output reg              ahb_m1_hwrite,
    output reg [2:0]        ahb_m1_hsize,
    output reg [2:0]        ahb_m1_hburst,
    output reg [3:0]        ahb_m1_hprot,
    output reg [31:0]       ahb_m1_hwdata,
    output reg              ahb_m1_hready_in,
    input    [31:0]         ahb_m1_hrdata,
    input                   ahb_m1_hready,
    input    [1:0]          ahb_m1_hresp,
    //M2
    output reg              ahb_m2_hsel,
    output reg [31:0]       ahb_m2_haddr,
    output reg [1:0]        ahb_m2_htrans,
    output reg              ahb_m2_hwrite,
    output reg [2:0]        ahb_m2_hsize,
    output reg [2:0]        ahb_m2_hburst,
    output reg [3:0]        ahb_m2_hprot,
    output reg [31:0]       ahb_m2_hwdata,
    output reg              ahb_m2_hready_in,
    input    [31:0]         ahb_m2_hrdata,
    input                   ahb_m2_hready,
    input    [1:0]          ahb_m2_hresp,
    //M3
    output reg              ahb_m3_hsel,
    output reg [31:0]       ahb_m3_haddr,
    output reg [1:0]        ahb_m3_htrans,
    output reg              ahb_m3_hwrite,
    output reg [2:0]        ahb_m3_hsize,
    output reg [2:0]        ahb_m3_hburst,
    output reg [3:0]        ahb_m3_hprot,
    output reg [31:0]       ahb_m3_hwdata,
    output reg              ahb_m3_hready_in,
    input    [31:0]         ahb_m3_hrdata,
    input                   ahb_m3_hready,
    input    [1:0]          ahb_m3_hresp,
    //M4
    output reg              ahb_m4_hsel,
    output reg [31:0]       ahb_m4_haddr,
    output reg [1:0]        ahb_m4_htrans,
    output reg              ahb_m4_hwrite,
    output reg [2:0]        ahb_m4_hsize,
    output reg [2:0]        ahb_m4_hburst,
    output reg [3:0]        ahb_m4_hprot,
    output reg [31:0]       ahb_m4_hwdata,
    output reg              ahb_m4_hready_in,
    input    [31:0]         ahb_m4_hrdata,
    input                   ahb_m4_hready,
    input    [1:0]          ahb_m4_hresp,
    //M5
    output reg              ahb_m5_hsel,
    output reg [31:0]       ahb_m5_haddr,
    output reg [1:0]        ahb_m5_htrans,
    output reg              ahb_m5_hwrite,
    output reg [2:0]        ahb_m5_hsize,
    output reg [2:0]        ahb_m5_hburst,
    output reg [3:0]        ahb_m5_hprot,
    output reg [31:0]       ahb_m5_hwdata,
    output reg              ahb_m5_hready_in,
    input    [31:0]         ahb_m5_hrdata,
    input                   ahb_m5_hready,
    input    [1:0]          ahb_m5_hresp
);

    reg [3:0] addroutport_d;
    reg [3:0] addroutport;


    always @(*)begin
        if(ahb_s_haddr[15:12] >= 4'h0 && ahb_s_haddr[15:12] <= 4'h1)
		    addroutport[3:0] = 4'h0;
        else if(ahb_s_haddr[15:12] >= 4'h2 && ahb_s_haddr[15:12] <= 4'h4)
		    addroutport[3:0] = 4'h1;
        else if(ahb_s_haddr[15:12] >= 4'h5 && ahb_s_haddr[15:12] <= 4'h6)
		    addroutport[3:0] = 4'h2;
        else if(ahb_s_haddr[15:12] >= 4'h7 && ahb_s_haddr[15:12] <= 4'h8)
		    addroutport[3:0] = 4'h3;
        else if(ahb_s_haddr[15:12] >= 4'ha && ahb_s_haddr[15:12] <= 4'ha)
		    addroutport[3:0] = 4'h4;
        else if(ahb_s_haddr[15:12] >= 4'he && ahb_s_haddr[15:12] <= 4'hf)
		    addroutport[3:0] = 4'h5;
        else 
            addroutport[3:0] = 4'hf;
    end
    always @(*)begin
        ahb_m0_hsel							= 1'h0;
        ahb_m0_haddr[31:0]					= 32'h0;
        ahb_m0_htrans[1:0]					= 2'h0;
        ahb_m0_hwrite						= 1'h0;
        ahb_m0_hsize[2:0]					= 3'h0;
        ahb_m0_hburst[2:0]					= 3'h0;
        ahb_m0_hprot[3:0]					= 4'h0;
        ahb_m0_hwdata[31:0]					= 32'h0;
        ahb_m0_hready_in					= 1'h0;
        ahb_m1_hsel							= 1'h0;
        ahb_m1_haddr[31:0]					= 32'h0;
        ahb_m1_htrans[1:0]					= 2'h0;
        ahb_m1_hwrite						= 1'h0;
        ahb_m1_hsize[2:0]					= 3'h0;
        ahb_m1_hburst[2:0]					= 3'h0;
        ahb_m1_hprot[3:0]					= 4'h0;
        ahb_m1_hwdata[31:0]					= 32'h0;
        ahb_m1_hready_in					= 1'h0;
        ahb_m2_hsel							= 1'h0;
        ahb_m2_haddr[31:0]					= 32'h0;
        ahb_m2_htrans[1:0]					= 2'h0;
        ahb_m2_hwrite						= 1'h0;
        ahb_m2_hsize[2:0]					= 3'h0;
        ahb_m2_hburst[2:0]					= 3'h0;
        ahb_m2_hprot[3:0]					= 4'h0;
        ahb_m2_hwdata[31:0]					= 32'h0;
        ahb_m2_hready_in					= 1'h0;
        ahb_m3_hsel							= 1'h0;
        ahb_m3_haddr[31:0]					= 32'h0;
        ahb_m3_htrans[1:0]					= 2'h0;
        ahb_m3_hwrite						= 1'h0;
        ahb_m3_hsize[2:0]					= 3'h0;
        ahb_m3_hburst[2:0]					= 3'h0;
        ahb_m3_hprot[3:0]					= 4'h0;
        ahb_m3_hwdata[31:0]					= 32'h0;
        ahb_m3_hready_in					= 1'h0;
        ahb_m4_hsel							= 1'h0;
        ahb_m4_haddr[31:0]					= 32'h0;
        ahb_m4_htrans[1:0]					= 2'h0;
        ahb_m4_hwrite						= 1'h0;
        ahb_m4_hsize[2:0]					= 3'h0;
        ahb_m4_hburst[2:0]					= 3'h0;
        ahb_m4_hprot[3:0]					= 4'h0;
        ahb_m4_hwdata[31:0]					= 32'h0;
        ahb_m4_hready_in					= 1'h0;
        ahb_m5_hsel							= 1'h0;
        ahb_m5_haddr[31:0]					= 32'h0;
        ahb_m5_htrans[1:0]					= 2'h0;
        ahb_m5_hwrite						= 1'h0;
        ahb_m5_hsize[2:0]					= 3'h0;
        ahb_m5_hburst[2:0]					= 3'h0;
        ahb_m5_hprot[3:0]					= 4'h0;
        ahb_m5_hwdata[31:0]					= 32'h0;
        ahb_m5_hready_in					= 1'h0;
        if(ahb_s_hsel)begin
            case(addroutport[3:0])
            4'h0:begin
                ahb_m0_hsel						= 1'b1;
                ahb_m0_haddr[31:0]				= ahb_s_haddr;
                ahb_m0_htrans[1:0]				= ahb_s_htrans;
                ahb_m0_hwrite					= ahb_s_hwrite;
                ahb_m0_hsize[2:0]				= ahb_s_hsize;
                ahb_m0_hburst[2:0]				= ahb_s_hburst;
                ahb_m0_hprot[3:0]				= ahb_s_hprot;
                ahb_m0_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m0_hready_in				= ahb_s_hready_in;
            end
            4'h1:begin
                ahb_m1_hsel						= 1'b1;
                ahb_m1_haddr[31:0]				= ahb_s_haddr;
                ahb_m1_htrans[1:0]				= ahb_s_htrans;
                ahb_m1_hwrite					= ahb_s_hwrite;
                ahb_m1_hsize[2:0]				= ahb_s_hsize;
                ahb_m1_hburst[2:0]				= ahb_s_hburst;
                ahb_m1_hprot[3:0]				= ahb_s_hprot;
                ahb_m1_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m1_hready_in				= ahb_s_hready_in;
            end
            4'h2:begin
                ahb_m2_hsel						= 1'b1;
                ahb_m2_haddr[31:0]				= ahb_s_haddr;
                ahb_m2_htrans[1:0]				= ahb_s_htrans;
                ahb_m2_hwrite					= ahb_s_hwrite;
                ahb_m2_hsize[2:0]				= ahb_s_hsize;
                ahb_m2_hburst[2:0]				= ahb_s_hburst;
                ahb_m2_hprot[3:0]				= ahb_s_hprot;
                ahb_m2_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m2_hready_in				= ahb_s_hready_in;
            end
            4'h3:begin
                ahb_m3_hsel						= 1'b1;
                ahb_m3_haddr[31:0]				= ahb_s_haddr;
                ahb_m3_htrans[1:0]				= ahb_s_htrans;
                ahb_m3_hwrite					= ahb_s_hwrite;
                ahb_m3_hsize[2:0]				= ahb_s_hsize;
                ahb_m3_hburst[2:0]				= ahb_s_hburst;
                ahb_m3_hprot[3:0]				= ahb_s_hprot;
                ahb_m3_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m3_hready_in				= ahb_s_hready_in;
            end
            4'h4:begin
                ahb_m4_hsel						= 1'b1;
                ahb_m4_haddr[31:0]				= ahb_s_haddr;
                ahb_m4_htrans[1:0]				= ahb_s_htrans;
                ahb_m4_hwrite					= ahb_s_hwrite;
                ahb_m4_hsize[2:0]				= ahb_s_hsize;
                ahb_m4_hburst[2:0]				= ahb_s_hburst;
                ahb_m4_hprot[3:0]				= ahb_s_hprot;
                ahb_m4_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m4_hready_in				= ahb_s_hready_in;
            end
            4'h5:begin
                ahb_m5_hsel						= 1'b1;
                ahb_m5_haddr[31:0]				= ahb_s_haddr;
                ahb_m5_htrans[1:0]				= ahb_s_htrans;
                ahb_m5_hwrite					= ahb_s_hwrite;
                ahb_m5_hsize[2:0]				= ahb_s_hsize;
                ahb_m5_hburst[2:0]				= ahb_s_hburst;
                ahb_m5_hprot[3:0]				= ahb_s_hprot;
                ahb_m5_hwdata[31:0]				= ahb_s_hwdata;
                ahb_m5_hready_in				= ahb_s_hready_in;
            end
            default:;
            endcase
        end
    end


    always @(posedge hclk or negedge hresetn)begin
        if(!hresetn)
            addroutport_d[3:0] <= 4'h0;
        else 
            addroutport_d[3:0] <= addroutport;
    end


    always @(*)begin
        if(ahb_s_hsel)begin
            case(addroutport_d[3:0])
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m0_hrdata;
                ahb_s_hready                = ahb_m0_hready;
                ahb_s_hresp[1:0]            = ahb_m0_hresp;
            end
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m1_hrdata;
                ahb_s_hready                = ahb_m1_hready;
                ahb_s_hresp[1:0]            = ahb_m1_hresp;
            end
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m2_hrdata;
                ahb_s_hready                = ahb_m2_hready;
                ahb_s_hresp[1:0]            = ahb_m2_hresp;
            end
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m3_hrdata;
                ahb_s_hready                = ahb_m3_hready;
                ahb_s_hresp[1:0]            = ahb_m3_hresp;
            end
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m4_hrdata;
                ahb_s_hready                = ahb_m4_hready;
                ahb_s_hresp[1:0]            = ahb_m4_hresp;
            end
            4'd0:begin
                ahb_s_hrdata[31:0]          = ahb_m5_hrdata;
                ahb_s_hready                = ahb_m5_hready;
                ahb_s_hresp[1:0]            = ahb_m5_hresp;
            end
            default:begin
                ahb_s_hrdata[31:0]          = 32'h0;
                ahb_s_hready                = 1'h1;
                ahb_s_hresp[1:0]            = 2'h0;
            end
            endcase
        end
    end

endmodule