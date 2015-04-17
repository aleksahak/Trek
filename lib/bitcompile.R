################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
################################################################################
LibPath      = "."
MutRatePath  = "noqpolya"
################################################################################

suppressWarnings(suppressPackageStartupMessages(library(compiler)))
source(paste(LibPath,"/Seq2Index.R",sep=""))
source(paste(LibPath,"/readfasta.R",sep=""))
source(paste(LibPath,"/getBaseAfterMut.R",sep=""))
source(paste(LibPath,"/getMutParIndex.R",sep=""))
source(paste(LibPath,"/INFOline.R",sep=""))
source(paste(LibPath,"/get1merLine.R",sep=""))
source(paste(LibPath,"/getOUT.R",sep=""))
source(paste(LibPath,"/getEND.R",sep=""))
source(paste(LibPath,"/Trek.R",sep=""))
Seq2Index        <- cmpfun(Seq2Index,       options=list(suppressUndefined=TRUE))
readfasta        <- cmpfun(readfasta,       options=list(suppressUndefined=TRUE))
getBaseAfterMut  <- cmpfun(getBaseAfterMut, options=list(suppressUndefined=TRUE))
getMutParIndex   <- cmpfun(getMutParIndex,  options=list(suppressUndefined=TRUE))
INFOline         <- cmpfun(INFOline,        options=list(suppressUndefined=TRUE))
get1merLine      <- cmpfun(get1merLine,     options=list(suppressUndefined=TRUE))
getOUT           <- cmpfun(getOUT,          options=list(suppressUndefined=TRUE))
getEND           <- cmpfun(getEND,          options=list(suppressUndefined=TRUE))
Trek             <- cmpfun(Trek,            options=list(suppressUndefined=TRUE))
mutrate.par.sym   <- readLines(paste(MutRatePath,"/MutRate_SYM.par",sep=""))
mutrate.par.nosym <- readLines(paste(MutRatePath,"/MutRate.par",sep=""))

save(list=c("get1merLine",
            "getBaseAfterMut",
            "getMutParIndex",
            "INFOline",
            "readfasta",
            "Seq2Index",
            "getOUT",
            "getEND",
            "Trek",
            "mutrate.par.sym",
            "mutrate.par.nosym"), file="../Trek.lib")

################################################################################
