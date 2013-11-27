//Automaticly generated file!!!! Do not edit!!!
else if((addresses==256)&&(width==8))
  begin   
     someOnePortVendorMem_256_8_16 mem(.A (address),
				 .CLK (clk),
				 .CEN (~(readEnable|writeEnable)),
				 .D   (writeData),
				 .WEN (~writeEnable),
				 .OEN (1'b0),
				 .Q   (readData) );
  end
else if((addresses==2048)&&(width==8)&&(muxFactor==16))
  begin   
     someOnePortVendorMem_2048_8_16 mem(.A (address),
				 .CLK (clk),
				 .CEN (~(readEnable|writeEnable)),
				 .D   (writeData),
				 .WEN (~writeEnable),
				 .OEN (1'b0),
				 .Q   (readData) );
  end
else if((addresses==2048)&&(width==8)&&(muxFactor==0))
  begin   
     someOnePortVendorMem_2048_8_0 mem(.A (address),
				 .CLK (clk),
				 .CEN (~(readEnable|writeEnable)),
				 .D   (writeData),
				 .WEN (~writeEnable),
				 .OEN (1'b0),
				 .Q   (readData) );
  end
else if((addresses==2048)&&(width==8))
  begin   
     someOnePortVendorMem_2048_8_0 mem(.A (address),
				 .CLK (clk),
				 .CEN (~(readEnable|writeEnable)),
				 .D   (writeData),
				 .WEN (~writeEnable),
				 .OEN (1'b0),
				 .Q   (readData) );
  end
