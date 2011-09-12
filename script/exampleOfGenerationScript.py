#!/usr/bin/env python

from optparse import OptionParser
import glob
import os


class exampleOfGenerationScript:
    def __init__(self,srcDir,destDir):
        self.srcDir  = srcDir
        self.destDir = destDir
        self.onePortMemPrefix = 'someOnePortVendorMem'
        self.twoPortMemPrefix = 'someTwoPortVendorMem'        
        dictOfOnePortMem = self.returnDictOfMemInDir(self.srcDir,self.onePortMemPrefix)
        dictOfTwoPortMem = self.returnDictOfMemInDir(self.srcDir,self.twoPortMemPrefix)
        fileName = "scriptGeneratedListOfVendorOnePortMems.vh"
        self.genPortMemIncludeFile(self.onePortMemPrefix,fileName,dictOfOnePortMem)
        fileName = "scriptGeneratedListOfVendorTwoPortMems.vh"
        self.genPortMemIncludeFile(self.twoPortMemPrefix,fileName,dictOfTwoPortMem)        


    def genPortMemIncludeFile(self,prefix,fileName,dictOfMem):
        #This code is a bit tricky. Normaly an ASIC Designer dont care about the muxfactor. 
        #The only thing the muxfactor effect is the layout.
        #If no muxfactor is met, a mem will still be instanciated. 
        #The one with the lowest value will be selected.        
        st = "//Automaticly generated file!!!! Do not edit!!!\n"
        for key in dictOfMem.keys():
            memList = dictOfMem[key]
            if len(memList)==1:
                memDict = memList[0]
                st = st + self.connectionTemplate(prefix,memDict['addresses'],memDict['width'],memDict['muxFactor'],True)
            else:
                muxFactorList = []
                for memDict in memList :
                    st = st + self.connectionTemplate(prefix,memDict['addresses'],memDict['width'],memDict['muxFactor'],False)
                    muxFactorList.append(int(memDict['muxFactor']))
                minMuxFactorValue = min(muxFactorList)
                for memDict in memList :
                    if memDict['muxFactor'] == str(minMuxFactorValue):
                        st = st + self.connectionTemplate(prefix,memDict['addresses'],memDict['width'],memDict['muxFactor'],True)
        
        f = open(self.destDir+'/'+fileName, 'w')
        f.write(st)





    def connectionTemplate(self,prefix,addresses,width,muxFactor,onlyOne):
        memName = prefix + "_" + addresses + "_" +width + "_" + muxFactor
        st = ""
        if onlyOne:
            st = st + "else if((addresses=="+addresses+")&&(width=="+width+"))\n"
        else:
            st = st + "else if((addresses=="+addresses+")&&(width=="+width+")&&(muxFactor=="+muxFactor+"))\n"

        if prefix == self.onePortMemPrefix:
            st = st + "  begin   \n"                                
            st = st + "     " + memName + " mem(.A (address),\n"
            st = st + "				 .CLK (clk),\n"
            st = st + "				 .CEN (~(readEnable|writeEnable)),\n"
            st = st + "				 .D   (writeData),\n"
            st = st + "				 .WEN (~writeEnable),\n"
            st = st + "				 .OEN (1'b0),\n"
            st = st + "				 .Q   (readData) );\n"
            st = st + "  end\n"
        else:
            st = st + " begin\n"                                        
            st = st + "   " + memName + "   mem(.QA     (readData),\n"
            st = st + "					.CLKA   (readClk),\n"
            st = st + "					.CENA   (~readEnable),\n"
            st = st + "					.WENA   (1'b1),\n"
            st = st + "					.AA     (readAddress),\n"
            st = st + "					.DA     ({"+width+"{1'b0}}),\n"
            st = st + "					.OENA   (1'b0),\n"
            st = st + "					.QB     (),\n"
            st = st + "					.CLKB   (writeClk),\n"
            st = st + "					.CENB   (~writeEnable),\n"
            st = st + "					.WENB   (1'b0),\n"
            st = st + "					.AB     (writeAddress),\n"
            st = st + "					.DB     (writeData),\n"
            st = st + "					.OENB   (1'b0));\n"
            st = st + " end \n"          

        return st

    def returnDictOfMemInDir(self,srcDir,prefix):
        fileList = glob.glob(srcDir + '/' + prefix + '*.v')
        result = {}
        for fileName in fileList:
            name = os.path.basename(fileName)
            (shortname, extension) = os.path.splitext(name)
            print shortname
            (tPrefix,addresses,width,muxFactor) = shortname.split('_')
            addresses_width = addresses+'_'+width
            if result.has_key(addresses_width):
                l = result[addresses_width]
            else:
                l = []
            l.append({'addresses':addresses,'width':width,'muxFactor':muxFactor})
            result[addresses_width] = l            
        return result

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option("-s", "--srcDir", dest="srcDir",
                      help="traverse directory DIR for memories", metavar="DIR")
    parser.add_option("-d", "--destDir", dest="destDir",
                      help="write generated files to DIR", metavar="DIR")
    (options, args) = parser.parse_args()
    
    e = exampleOfGenerationScript(options.srcDir,options.destDir)

