Synthesizable Generic Memory
----------------------------

A Verilog module that can be specialised from a simulation model to a vendor memory, without manually changing a line of RTL!

In an ASIC project a lot a time is needlessly consumed by they way memories are handled . Time is wasted, waiting for new models, instantiating the new models, changing code to fit new vendor memories. Over and over again.  A lot of time is also wasted developing a design, using the real size of a memory, when its faster in the development face to use a smaller memory. This extrapolates very well. No matter the design, if it is not generic, you are not doing it correctly!!

There are also significant SCM and reuse, advantages to using a generic memory.

The general principle is simple

Instantiate a module that depending on parameters (generics) instantiates different memory models.

If you have no vendor models, instantiate a generic memory model.
If you have vendor models, have a simple switch statement that instantiates the memory of the correct size.
Generate the switch statement with a script that goes through your memory models. Include the switch statement in your code.

Voila! A generic memory that is synthesizable.

So lets show how its done in code

Assume that you have a bunch of memories in a directory.

```bash
ls -1 vendorMemModels/
someOnePortVendorMem_2048_8_16.v
someOnePortVendorMem_256_8_16.v
```

With the naming convention of {vendorName}_{numberOfAddresses}_{width}_{muxfactor}.v
The muxfactor is, as all know, only interesting from a layout point of view.

Traverse your vendor memory models with a script in your favourite language (which of course is Python) and generate some code that looks somewhat like this:

```v
//Automaticly generated file!!!! Do not edit!!!
//fileName : scriptGeneratedListOfVendorOnePortMems.vh
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
else if((addresses==2048)&&(width==8))
  begin
     someOnePortVendorMem_2048_8_16 mem(.A (address),
                 .CLK (clk),
                 .CEN (~(readEnable|writeEnable)),
                 .D   (writeData),
                 .WEN (~writeEnable),
                 .OEN (1'b0),
                 .Q   (readData) );
  end
```

That was the automaticly generated part of the switch statement. Lets have a look at the rest.
We need a module to instantiate.

```v
module onePortMem(readData,
          readEnable,
          address,
          clk,
          writeEnable,
          writeData);
   //user defined
   parameter               addresses   = 32;
   parameter           width       = 8;
   parameter           muxFactor   = 0;
 
   //Auto-calculated, user dont touch
   localparam          addressWidth =clogb2(addresses);
 
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
```

Since I am a firm believer on version control, I put some executable example code on github.com. There I have also made some code for two port memories. The Makefile requires that you have a proprietary simulation tool (Modelsim/Questasim) in your path. If you don’t have it, feel free to update the Makefile for other tools and commit it.
In order to check it out and run it :

```bash
git clone http://github.com/oddball/genMem.git
cd genMem
make
```

In my example code there is a lot of issues that I have not touched. I have not touched them because I don’t want to cloud the general idea. But they are as well overcomeable. The main issue is BIST. BIST’s come in wide variety of forms. If they are parameterised, which they seldom are, it would be possible to solve the problem with including them in the Module “onePortMem”. Most likely they are not. Then it is possible to specialise them in the same manor as the memories. Can be nicely done with putting an BIST interface in a SystemVerilog interface and then specialise that interface in each project (when the specifics of the BIST interface is known). But there are other ways to handle it. It is also possible to handle write-masks etc, but again I have not put it here, because it clouds the concept.

The concept of “active-low” is a menace (except for reset which is generally accepted). It has caused numerous bugs, so I don’t use it in the module “onePortMem”.
