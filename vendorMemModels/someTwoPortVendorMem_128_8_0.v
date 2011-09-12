`timescale 1 ns/1 ps
module someTwoPortVendorMem_128_8_0 (QA,
				       CLKA,
				       CENA,  
				       WENA,  
				       AA,  
				       DA,    
				       OENA,
				       QB,  
				       CLKB,
				       CENB,  
				       WENB,  
				       AB,  
				       DB,    
				       OENB);
   output  [7:0]   QA;
   input 	   CLKA;
   input 	   CENA;
   input 	   WENA;
   input [6:0]     AA;
   input [7:0] 	   DA;
   input 	   OENA;
   
   output [7:0]    QB;
   input 	   CLKB;
   input 	   CENB;
   input 	   WENB;
   input [6:0] 	   AB;
   input [7:0] 	   DB;
   input 	   OENB;
   
   reg [7:0] 	   mem [127:0];
   reg [7:0] 	   QA,QB;
   
   initial
     begin
	$display("%m : someTwoPortVendorMem_128_8_0 instantiated.");
     end
   
   always @(posedge CLKA) 
     begin
	if((CENA == 0)&&(WENA==0))
	  begin
	     mem[AA] <= DA;
	  end
	else if((CENA == 0)&&(WENA==1))
	  begin
	     QA <=mem[AA];
	  end	
     end
   
   always @(posedge CLKB) 
     begin
	if((CENB == 0)&&(WENB==0))
	  begin
	     mem[AB] <= DB;
	  end
	else if((CENB == 0)&&(WENB==1))
	  begin
	     QB <=mem[AB];
	  end	
     end
endmodule
