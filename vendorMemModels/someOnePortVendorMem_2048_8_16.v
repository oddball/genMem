`timescale 1 ns/1 ps
module someOnePortVendorMem_2048_8_16(A,
				      CLK,
				      CEN,
				      D,
				      WEN,
				      OEN,
				      Q);
   input [10:0] A;
   input 	CLK;
   input 	CEN;
   input [7:0] 	D;
   input 	WEN;
   input 	OEN;   
   output [7:0] Q;
   
   reg [7:0] 	mem [2047:0];
   reg [7:0] 	Q;
   
   initial
     begin
	$display("%m : someOnePortVendorMem_2048_8_16 instantiated.");
     end   
   
   always @(posedge CLK) 
     begin
	if((CEN == 0)&&(WEN==0))
	  begin
	     mem[A] <= D;
	  end
	else if((CEN == 0)&&(WEN==1))
	  begin
	     Q <=mem[A];
	  end	
     end
endmodule
