//Copyright 2011 Andreas Lindh
//This file is part of genMem.
//genMem is free software: you can redistribute it and/or modify
//it under the terms of the GNU Lesser General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//genMem is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU Lesser General Public License for more details.
//
//You should have received a copy of the GNU Lesser General Public License
//along with genMem.  If not, see <http://www.gnu.org/licenses/>.

`timescale 1 ns/1 ps
module onePortMem(readData,
		  readEnable,
		  address,
		  clk,
		  writeEnable,		  
		  writeData);

		  
`include "clogb2.vh"

   //user defined  
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  

   //Auto-calculated, user dont touch
   localparam		   addressWidth =clogb2(addresses);   
   
   output [width-1:0] 	     readData;  
   input 	   	     readEnable; 
   input [addressWidth-1:0]  address;
   input 		     clk;
   input 		     writeEnable;
   input [width-1:0] 	     writeData;
   

   generate
      if((addresses==0)&&(width==0))
	begin
	   initial
	     begin
		$display("FAIL!! :%m:Parameters, addresses and width can not be set to 0");
		$stop;
	     end
        end      
`include "scriptGeneratedListOfVendorOnePortMems.vh"
      else
	begin
	   onePortSimMem   #(.addresses  (addresses),
                             .width      (width),
                             .muxFactor (muxFactor)
			     ) mem (.readData(readData),
				    .readEnable(readEnable),
				    .address(address),
				    .clk(clk),
				    .writeEnable(writeEnable),		  
				    .writeData(writeData));
	end
   endgenerate
endmodule // onePortMem






module onePortSimMem(readData,
		     readEnable,
		     address,
		     clk,
		     writeEnable,		  
		     writeData);
   
`include "clogb2.vh"
   
   //user defined  
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  
   
   //Auto-calculated, user dont touch
   localparam		   addressWidth =clogb2(addresses);   
   
   output [width-1:0] 	     readData;  
   input 	   	     readEnable; 
   input [addressWidth-1:0]  address;
   input 		     clk;
   input 		     writeEnable;
   input [width-1:0] 	     writeData;
   
   reg [width-1:0] 	     mem [addresses-1:0];
   reg [width-1:0] 	     readData;
   
   initial
     begin
	$display("%m : simulation model of memory");
     end   
   
   always @(posedge clk)
     begin
	if (writeEnable)
	  begin
	     mem[address] <= writeData;
	  end
	else if(readEnable)
	  begin
	     readData <= mem[address];
	  end
     end
endmodule
