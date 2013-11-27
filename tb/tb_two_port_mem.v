//SIMPLE TESTBENCH TO VERIFY THAT THINGS ARE ALIVE AND KICKING
`timescale 1 ns/1 ps
module tb_two_port_mem;

   
   parameter               addresses   = 32;
   parameter		   width       = 8;
   parameter 		   muxFactor   = 0;  
   //Auto-calculated, user dont touch
   localparam		   addressWidth =$clog2(addresses);


   reg [addressWidth-1:0] writeAddress;
   reg 			  writeEnable;
   reg [width-1:0] 	  writeData;
   
   reg [addressWidth-1:0] readAddress;
   reg 			  readEnable;  
   wire [width-1:0] 	  readData;  
   
   reg 			     clk;

   
   initial
     begin
	writeAddress=0;
	writeEnable=0;
	writeData=0;

	readAddress=0;
	readEnable=0;

	clk=0;
     end
   
   always
     begin
	#5 clk = ~clk;
     end
   
   integer i,k;
   
   initial
     begin
	repeat(10)@(posedge clk);	
	for(i=0;i<addresses;i=i+1)
	  begin
	     writeAddress=i;
	     writeEnable=1;
	     writeData=0;
	     writeData=i[width-1:0];
	     @(posedge clk);
	  end
	writeAddress=0;
	writeEnable=0;
	writeData=0;	
     end

   initial
     begin
	repeat(12)@(posedge clk);
	for(k=0;k<addresses;k=k+1)
	  begin
	     readAddress=k;
     	     readEnable=1;
	     @(posedge clk);
	     #1;
	     if(readData[width-1:0] != k[width-1:0])
	       begin
		  $display("ERROR");
		  $finish;
	       end
	  end // for (k=0;k<addresses;k=k+1)
	readAddress=0;
     	readEnable=0;	
	$display("Tested %d addresses",addresses);
	$display("PASS");
	$finish; 
     end	



   
   twoPortMem   #(.addresses  (addresses),
                     .width      (width),
                     .muxFactor (muxFactor)
		     ) mem (.writeAddress(writeAddress),		   
			    .writeClk(clk),
			    .writeEnable(writeEnable),
			    .writeData(writeData),		   
			    .readAddress(readAddress),
			    .readClk(clk),
			    .readEnable(readEnable),
			    .readData(readData));


endmodule // tb
