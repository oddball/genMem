`timescale 1 ns/1 ps
module someOnePortVendorMem_256_8_16(A,
			      CLK,
			      CEN,
			      D,
			      WEN,
			      OEN,
			      Q);
   input [7:0] 	A;
   input 	CLK;
   input 	CEN;
   input [7:0] 	D;
   input 	WEN;
   input 	OEN;   
   output [7:0] Q;
   
   reg [7:0] 	mem [255:0];
   reg [7:0] 	Q;

   initial
     begin
	$display("%m : someVendorMem_256_8_16 instantiated.");
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
