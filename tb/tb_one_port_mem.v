//SIMPLE TESTBENCH TO VERIFY THAT THINGS ARE ALIVE AND KICKING
`timescale 1 ns/1 ps
module tb_one_port_mem;

`include "clogb2.vh"
   
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  
   //Auto-calculated, user dont touch
   localparam		   addressWidth =clogb2(addresses);

   
   wire [width-1:0] 	     readData;  
   reg 			     readEnable; 
   reg [addressWidth-1:0]    address;
   reg 			     clk;
   reg 			     writeEnable;
   reg [width-1:0] 	     writeData;
   
   initial
     begin
	readEnable=0;
	address=0;
	clk=0;
	writeEnable=0;
	writeData=0;
     end
   
   always
     begin
	#5 clk = ~clk;
     end
   
   integer i;
   
   initial
     begin
	repeat(10)@(posedge clk);	
	for(i=0;i<addresses;i=i+1)
	  begin
	     readEnable =0;
	     address =i;
  	     writeEnable =1;
  	     writeData= i[width-1:0];
	     @(posedge clk);
	  end
	readEnable=0;
	address=0;
	writeEnable=0;
	writeData=0;
	repeat(10)@(posedge clk);	
	for(i=0;i<addresses;i=i+1)
	  begin
	     readEnable=1;
	     address =i;
  	     writeEnable =0;
  	     writeData= 0;
	     @(posedge clk);
	     if(readData[width-1:0] != i[width-1:0])
	       begin
		  $display("ERROR");
		  $finish;
	       end
	  end // for (i=0;i<addresses;i=i+1)
	$display("Tested %d addresses",addresses);
	$display("PASS");
	$finish; 
     end	


   onePortMem   #(.addresses  (addresses),
                  .width      (width),
                  .muxFactor (muxFactor)
		  ) mem (.readData(readData),
			 .readEnable(readEnable),
			 .address(address),
			 .clk(clk),
			 .writeEnable(writeEnable),		  
			 .writeData(writeData));
endmodule // tb
