   function integer clogb2 (input integer depth);
      integer i;
      begin
         clogb2 = 1;
	 for(i=0; 2**i<depth; i=i+1)
	   begin
	      clogb2 = i+1;
	   end	 
      end
   endfunction  
