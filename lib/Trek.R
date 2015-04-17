################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
# If nCPU>1, requires the libraries "doMC", "foreach" and "itertools".         #
# If not already installed in R, you can install those by typing:              #
# install.packages(c("doMC", "foreach" and "itertools"))                       #
################################################################################
Trek <- function(FastaFile    = "test.fasta",
                 OutFile      = "out.txt",
                 MutRates     = "sym", # "nosym"
                 nCPU         = 1,
                 shiny        = FALSE,
                 parsed.seq   = ""){
################################################################################

  if(nCPU>1){
    suppressWarnings(suppressPackageStartupMessages(library(doMC)))
    suppressWarnings(suppressPackageStartupMessages(library(foreach)))
    suppressWarnings(suppressPackageStartupMessages(library(itertools)))
    registerDoMC(cores = nCPU)
  }

  if(MutRates=="sym")  { mutrate.par <- mutrate.par.sym  }
  if(MutRates=="nosym"){ mutrate.par <- mutrate.par.nosym}

  info <- INFOline(OUT=info, msg=
  "NOTE: *:)* TRansposon Exposed k, neutral mutation rate constant, mapper. *(:*",
  initial=TRUE)

  info <- INFOline(OUT=info, msg=
  paste("NOTE: Stardate - ", date(), sep=""))
  
  info <- INFOline(OUT=info, msg=
  paste("NOTE: Database - ", MutRates, ".", sep=""))

  info <- INFOline(OUT=info, msg=
  "NOTE: Parsing the sequence...")
  if(parsed.seq==""){
    seq <- readfasta(FastaFile)
  } else {
    seq <- NULL
    seq$seq <- unlist(strsplit( paste(parsed.seq, collapse=""), ""))
    seq$length <- length(seq$seq)
  }

  info <- INFOline(OUT=info, msg=
  paste("NOTE: The digested sequence is of ", seq$length, "-nt length.", sep=""))

  info <- INFOline(OUT=info, msg=
  paste("NOTE: Mapping Trek data using ", nCPU, " processing core(s).", sep=""))

  mrpar.ind <- getMutParIndex(LENGTH=seq$length, sequence=seq$seq, ilim=NULL, ncpu=nCPU)
  
  info <- INFOline(OUT=info, msg=
  "NOTE: Formatting and saving the results...")
  
  mr        <- mutrate.par[mrpar.ind]
  na.lines  <- which(is.na(mr))
  na.bases  <- seq$seq[na.lines]
  mr[na.lines] <- sapply(na.bases, FUN=get1merLine, simplify=TRUE, USE.NAMES=FALSE)

  OUTPUT <- getOUT(LENGTH=seq$length, mr=mr)
  ending <- getEND()
  RESULT <- c(info, OUTPUT, ending)
  
  if(shiny==FALSE){
    write(RESULT, file=OutFile)
  } else {
    return(RESULT)
  }
  
  print("NOTE: Trek is done!", quote=FALSE)

}
## FUNCTION ####################################################################
