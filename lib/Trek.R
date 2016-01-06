################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
# Requires the libraries "doMC", "foreach" and "itertools".                    #
# If not already installed in R, you can install those by typing:              #
# install.packages(c("doMC", "foreach" and "itertools"))                       #
################################################################################
Trek <- function(FastaFile    = "test.fasta",
                 OutFile      = "out.txt",
                 MutRates     = "sym", # "nosym"
                 nCPU         = 1,
                 parsed.seq   = ""){
################################################################################


  suppressWarnings(suppressPackageStartupMessages(library(doMC)))
  suppressWarnings(suppressPackageStartupMessages(library(foreach)))
  suppressWarnings(suppressPackageStartupMessages(library(itertools)))
  registerDoMC(cores = nCPU)


  if(MutRates=="sym")  { mutrate.par <- mutrate.par.sym  }
  if(MutRates=="nosym"){ mutrate.par <- mutrate.par.nosym}

  info <- INFOline(OUT=info, msg=
  "NOTE: *:)* TRansposon Exposed k, core substitution rate constant, mapper. *(:*",
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

  # A number or NA for non-7mer terminal nucleotides.
  mrpar.ind <- getMutParIndex(LENGTH=seq$length, sequence=seq$seq, ilim=NULL, ncpu=nCPU)
  
  info <- INFOline(OUT=info, msg=
  "NOTE: Formatting and saving the results...")
  
  write(info, file=OutFile)
  
  out.start <- getSTART()
  write(out.start, file=OutFile, append=TRUE)
  ## Formatting the output, ~1-mln-nt positions at a time.
  ## Non-parallel execution (for the sake of safe disk writing).
  save.success <- foreach(pos=isplitVector(1:seq$length, chunks=ceiling(seq$length/1000000)),
                          .combine="c", .inorder=TRUE) %do% {
      
    mr        <- mutrate.par[ mrpar.ind[pos] ]
    na.lines  <- which(is.na(mr))
    na.bases  <- seq$seq[pos[na.lines]]
    mr[na.lines] <- sapply(na.bases, FUN=get1merLine, simplify=TRUE, USE.NAMES=FALSE)
    OUTPUT.CHUNK <- paste("DATA:", pos, mr, sep=" ")
    write( OUTPUT.CHUNK, file=OutFile, append=TRUE )                 
    return(1)
      
  }
  ##
  out.end <- getEND()
  write(out.end, file=OutFile, append=TRUE)

  print("NOTE: Trek is done!", quote=FALSE)
  return(c(info, out.end))

  ## Old version of output formatting and return (before 2 July, 2015)
  ##!!
  #mr        <- mutrate.par[mrpar.ind]
  #na.lines  <- which(is.na(mr))
  #na.bases  <- seq$seq[na.lines]
  #mr[na.lines] <- sapply(na.bases, FUN=get1merLine, simplify=TRUE, USE.NAMES=FALSE)
  #
  #OUTPUT <- getOUT(LENGTH=seq$length, mr=mr)
  #ending <- getEND()
  #RESULT <- c(info, OUTPUT, ending)
  # 
  #if(shiny==FALSE){
  #  write(RESULT, file=OutFile)
  #} else {
  #  return(RESULT)
  #}
  #^^
  
}
## FUNCTION ####################################################################
