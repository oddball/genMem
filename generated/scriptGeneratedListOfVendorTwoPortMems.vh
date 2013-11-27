//Automaticly generated file!!!! Do not edit!!!
else if((addresses==4096)&&(width==32)&&(muxFactor==0))
 begin
   someTwoPortVendorMem_4096_32_0   mem(.QA     (readData),
					.CLKA   (readClk),
					.CENA   (~readEnable),
					.WENA   (1'b1),
					.AA     (readAddress),
					.DA     ({32{1'b0}}),
					.OENA   (1'b0),
					.QB     (),
					.CLKB   (writeClk),
					.CENB   (~writeEnable),
					.WENB   (1'b0),
					.AB     (writeAddress),
					.DB     (writeData),
					.OENB   (1'b0));
 end 
else if((addresses==4096)&&(width==32)&&(muxFactor==8))
 begin
   someTwoPortVendorMem_4096_32_8   mem(.QA     (readData),
					.CLKA   (readClk),
					.CENA   (~readEnable),
					.WENA   (1'b1),
					.AA     (readAddress),
					.DA     ({32{1'b0}}),
					.OENA   (1'b0),
					.QB     (),
					.CLKB   (writeClk),
					.CENB   (~writeEnable),
					.WENB   (1'b0),
					.AB     (writeAddress),
					.DB     (writeData),
					.OENB   (1'b0));
 end 
else if((addresses==4096)&&(width==32))
 begin
   someTwoPortVendorMem_4096_32_0   mem(.QA     (readData),
					.CLKA   (readClk),
					.CENA   (~readEnable),
					.WENA   (1'b1),
					.AA     (readAddress),
					.DA     ({32{1'b0}}),
					.OENA   (1'b0),
					.QB     (),
					.CLKB   (writeClk),
					.CENB   (~writeEnable),
					.WENB   (1'b0),
					.AB     (writeAddress),
					.DB     (writeData),
					.OENB   (1'b0));
 end 
else if((addresses==128)&&(width==8))
 begin
   someTwoPortVendorMem_128_8_0   mem(.QA     (readData),
					.CLKA   (readClk),
					.CENA   (~readEnable),
					.WENA   (1'b1),
					.AA     (readAddress),
					.DA     ({8{1'b0}}),
					.OENA   (1'b0),
					.QB     (),
					.CLKB   (writeClk),
					.CENB   (~writeEnable),
					.WENB   (1'b0),
					.AB     (writeAddress),
					.DB     (writeData),
					.OENB   (1'b0));
 end 
