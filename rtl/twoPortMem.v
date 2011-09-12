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
module twoPortMem (
		   writeAddress,		   
		   writeClk,
		   writeEnable,
		   writeData,		   
		   readAddress,
		   readClk,
		   readEnable,
		   readData);
   
`include "clogb2.vh"

   //user defined  
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  

   //Auto-calculated, user dont touch
   localparam		   addressWidth =clogb2(addresses);   
   

 
   input [addressWidth-1:0] writeAddress;
   input 		    writeClk;   
   input 		    writeEnable;
   input [width-1:0] 	    writeData;
   
   input [addressWidth-1:0] readAddress;
   input 		    readClk;
   input 		    readEnable;  
   output [width-1:0] 	    readData;  
   

   generate
      if((addresses==0)&&(width==0))
	begin
	   initial
	     begin
		$display("FAIL!! :%m:Parameters, addresses and width can not be set to 0");
		$stop;
	     end
        end      
`include "scriptGeneratedListOfVendorTwoPortMems.vh"
      else
	begin
	   twoPortMemSim   #(.addresses  (addresses),
                             .width      (width),
                             .muxFactor (muxFactor)
			     ) mem (.writeAddress(writeAddress),		   
				    .writeClk(writeClk),
				    .writeEnable(writeEnable),
				    .writeData(writeData),		   
				    .readAddress(readAddress),
				    .readClk(readClk),
				    .readEnable(readEnable),
				    .readData(readData));
	end
   endgenerate
endmodule // twoPortMem




module twoPortMemSim (
		   writeAddress,		   
		   writeClk,
		   writeEnable,
		   writeData,		   
		   readAddress,
		   readClk,
		   readEnable,
		   readData);
   
`include "clogb2.vh"

   //user defined  
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  

   //Auto-calculated, user dont touch
   localparam		   addressWidth =clogb2(addresses);   
   
   input [addressWidth-1:0] writeAddress;
   input 		    writeClk;   
   input 		    writeEnable;
   input [width-1:0] 	    writeData;
    
   input [addressWidth-1:0] readAddress;
   input 		    readClk;
   input 		    readEnable;  
   output [width-1:0] 	    readData;  


   reg [width-1:0] 	     mem [addresses-1:0];
   reg [width-1:0] 	     readData;
   
   initial
     begin
	$display("%m : simulation model of memory");
     end   
  
   always @(posedge writeClk)
     begin
	if (writeEnable)
	  begin
	     mem[writeAddress] <= writeData;
	  end
     end

   always @(posedge writeClk)
     begin
	if(readEnable)
	  begin
	     readData <= mem[readAddress];
	  end
     end
   
endmodule
