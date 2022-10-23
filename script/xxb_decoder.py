#!/bin/python3
# -*- coding: utf-8 -*-
import sys
import os
import re
import pandas as pd
from datetime import datetime
import getpass

def main():
    try:
        #print(sys.argv)
        #print(len(sys.argv))

        para_list = sys.argv[1:]
        #print(para_list[0])
        #print(para_list[1])

    except Exception as e:
        print("Error parameters!!! unknown parameter")
        print(e)
        sys.exit(1)

    if(len(para_list) == 0) or para_list[0] == "-h":
        help()
        sys.exit(1)

    
    if para_list[2] == "dec_gen":
        df = pd.read_excel(para_list[0], sheet_name = para_list[1])
        dec_corpus = df.values.tolist()

        print("\nall data:")
        print (df)
        
        dec_ser = pd.Series(dec_corpus)
        #print(dec_ser)
        dec_gen(para_list, dec_corpus, dec_ser)


# dec_gen{{{
def dec_gen(para_list, dec_corpus, dec_ser):
	fp = open(para_list[1]+".v", "w") 
	print_line = []

	header(print_line, para_list[1]+".v")
    
	print_line.append("module "+para_list[1]+"(")
	print_line.append("    input                   hclk,")
	print_line.append("    input                   hresetn,")
	print_line.append("    //slave")
	print_line.append("    input                   ahb_s_hsel,")
	print_line.append("    input   [31:0]          ahb_s_haddr,")
	print_line.append("    input   [1:0]           ahb_s_htrans,")
	print_line.append("    input                   ahb_s_hwrite,")
	print_line.append("    input   [2:0]           ahb_s_hsize,")
	print_line.append("    input   [2:0]           ahb_s_hburst,")
	print_line.append("    input   [3:0]           ahb_s_hprot,")
	print_line.append("    input   [31:0]          ahb_s_hwdata,")
	print_line.append("    input                   ahb_s_hready_in,")
	print_line.append("    output reg  [31:0]      ahb_s_hrdata,")
	print_line.append("    output reg              ahb_s_hready,")
	print_line.append("    output reg  [1:0]       ahb_s_hresp,")
	count = 0
	for dec_info in dec_corpus:
		count += 1 
		print_line.append("    //"+dec_info[0])
		print_line.append("    output reg              ahb_"+dec_info[0].lower()+"_hsel,")
		print_line.append("    output reg [31:0]       ahb_"+dec_info[0].lower()+"_haddr,")
		print_line.append("    output reg [1:0]        ahb_"+dec_info[0].lower()+"_htrans,")
		print_line.append("    output reg              ahb_"+dec_info[0].lower()+"_hwrite,")
		print_line.append("    output reg [2:0]        ahb_"+dec_info[0].lower()+"_hsize,")
		print_line.append("    output reg [2:0]        ahb_"+dec_info[0].lower()+"_hburst,")
		print_line.append("    output reg [3:0]        ahb_"+dec_info[0].lower()+"_hprot,")
		print_line.append("    output reg [31:0]       ahb_"+dec_info[0].lower()+"_hwdata,")
		print_line.append("    output reg              ahb_"+dec_info[0].lower()+"_hready_in,")
		
		print_line.append("    input    [31:0]         ahb_"+dec_info[0].lower()+"_hrdata,")
		print_line.append("    input                   ahb_"+dec_info[0].lower()+"_hready,")
		print_line.append("    input    [1:0]          ahb_"+dec_info[0].lower()+"_hresp,")

		port_last_process(count, dec_ser, print_line)
	print_line.append(');\n')
	print_line.append("    reg [3:0] addroutport_d;")
	print_line.append("    reg [3:0] addroutport;")

	print_line.append("\n")
	print_line.append("    always @(*)begin")

	count = 0
	for dec_info in dec_corpus:

		start_addr_list = list(dec_info[1])
		end_addr_list   = list(dec_info[2])
		#print(start_addr_list)
		#print(end_addr_list)
		start_dec_num = start_addr_list[2] 
		end_dec_num = end_addr_list[2]
		if count == 0:
			print_line.append("        if(ahb_s_haddr[15:12] >= 4'h"+start_dec_num+" && ahb_s_haddr[15:12] <= 4'h"+end_dec_num+")")
		else:
			print_line.append("        else if(ahb_s_haddr[15:12] >= 4'h"+start_dec_num+" && ahb_s_haddr[15:12] <= 4'h"+end_dec_num+")")
		print_line.append("		    addroutport[3:0] = 4'h"+str(count)+";")
		count += 1 
	
	print_line.append("        else ")
	print_line.append("            addroutport[3:0] = 4'hf;")
	print_line.append("    end") 

	print_line.append("    always @(*)begin")

	for dec_info in dec_corpus:

		print_line.append("        ahb_"+dec_info[0].lower()+"_hsel							= 1'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_haddr[31:0]					= 32'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_htrans[1:0]					= 2'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hwrite						= 1'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hsize[2:0]					= 3'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hburst[2:0]					= 3'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hprot[3:0]					= 4'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hwdata[31:0]					= 32'h0;") 
		print_line.append("        ahb_"+dec_info[0].lower()+"_hready_in					= 1'h0;")

	print_line.append("        if(ahb_s_hsel)begin")
	print_line.append("            case(addroutport[3:0])")

	count = 0
	for dec_info in dec_corpus:
		
		print_line.append("            4'h"+str(count)+":begin")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hsel						= 1'b1;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_haddr[31:0]				= ahb_s_haddr;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_htrans[1:0]				= ahb_s_htrans;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hwrite					= ahb_s_hwrite;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hsize[2:0]				= ahb_s_hsize;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hburst[2:0]				= ahb_s_hburst;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hprot[3:0]				= ahb_s_hprot;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hwdata[31:0]				= ahb_s_hwdata;")
		print_line.append("                ahb_"+dec_info[0].lower()+"_hready_in				= ahb_s_hready_in;")	
		print_line.append("            end")


		count += 1 
	print_line.append("            default:;")
	print_line.append("            endcase")
	print_line.append("        end")
	print_line.append("    end")
	print_line.append("\n")
	print_line.append("    always @(posedge hclk or negedge hresetn)begin")
	print_line.append("        if(!hresetn)")
	print_line.append("            addroutport_d[3:0] <= 4'h0;")
	print_line.append("        else ")
	print_line.append("            addroutport_d[3:0] <= addroutport;")
	print_line.append("    end")

	print_line.append("\n")
	print_line.append("    always @(*)begin")
	print_line.append("        if(ahb_s_hsel)begin")
	print_line.append("            case(addroutport_d[3:0])")


	count = 0
	for dec_info in dec_corpus:
		print_line.append("            4'd0:begin")
		print_line.append("                ahb_s_hrdata[31:0]          = ahb_"+dec_info[0].lower()+"_hrdata;")
		print_line.append("                ahb_s_hready                = ahb_"+dec_info[0].lower()+"_hready;")
		print_line.append("                ahb_s_hresp[1:0]            = ahb_"+dec_info[0].lower()+"_hresp;")
		print_line.append("            end")

	print_line.append("            default:begin")
	print_line.append("                ahb_s_hrdata[31:0]          = 32'h0;")
	print_line.append("                ahb_s_hready                = 1'h1;")
	print_line.append("                ahb_s_hresp[1:0]            = 2'h0;")
	print_line.append("            end")
	print_line.append("            endcase")
	print_line.append("        end")
	print_line.append("    end")


	for line in print_line:
	    #print(line)
	    fp.write(line)
	    fp.write('\n')
	
	fp.write('\n')
	fp.write('endmodule')
	
	fp.close()
#}}}


#port_last_process{{{
def port_last_process(count, ser, print_line):
    if count > ser.index.max():
        print_line[-1] = print_line[-1].strip(',') 
#}}}

# header{{{
def header(print_line, filename):
    today = datetime.today()
    now = datetime.now()
    user = getpass.getuser()
    
    date1 = today.strftime("%Y/%m/%d")
    year = today.strftime("%Y")
    time = now.strftime("%H:%M")
    #print("date1 =", date1)
    #print("year =", year)
    #print("time =", time)
    #print(user)
    
    print_line.append("// +FHDR----------------------------------------------------------------------------")
    print_line.append("// Copyright (c) "+year+" SiliconPeasant.")
    print_line.append("// ALL RIGHTS RESERVED Worldwide")
    print_line.append("//         ")
    print_line.append("// Author        : "+user)
    print_line.append("// Email         : ninghechuan@foxmail.com")
    print_line.append("// Created On    : "+date1+" "+time)
    print_line.append("// Last Modified : "+date1+" "+time)
    print_line.append("// File Name     : "+filename)
    print_line.append("// Description   :")
    print_line.append("// ")
    print_line.append("// ---------------------------------------------------------------------------------")
    print_line.append("// Modification History:")
    print_line.append("// Date         By              Version                 Change Description")
    print_line.append("// ---------------------------------------------------------------------------------")
    print_line.append("// "+date1+"   "+user+"     1.0                     Original")
    print_line.append("// -FHDR----------------------------------------------------------------------------")

# }}}

# help{{{
def help():
    print("############## help ####################")
    print("########################################")
    print("generate dec_gen module")
    print("xxb_decoder.py excel_path sheet_name dec_gen")
    print("########################################")
# }}}

if __name__ == "__main__":
    main()
