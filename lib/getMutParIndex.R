################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
# This function, takes as arguments the DNA "sequence", as a vector of char.   #
# the "LENGTH" of the sequence (for speed), which it can also calculate        #
# internally if not provided and the "ilim" argument, which defines the borders#
# of the segment (vector of length two) for the nucleotides of which the rates #
# indexes are to be obtained. If "ilim" is NULL (default), then the calculation#
# will be done for the whole sequence.                                         #
# The function returns a vector of all the row indices in the MutRate.par para-#
# meter files that describe the mutation rates at the corresponding position of#
# the sequence. The NA values in the outcome denote the cases where either the #
# position is periterminal (pos<4 & pos>(LENGTH-3)) hence the average rates for#
# 1-mers are to be assigned later, or the 7-mer sequence (pos-3):(pos+3) con-  #
# tains ne or more undefined N nucleotides.                                    #
################################################################################
getMutParIndex <- function(sequence=seq, LENGTH=NULL, ilim=NULL, ncpu=1){

  if(is.null(LENGTH)){ LENGTH <- length(sequence) }
  if(is.null(ilim))  {   ilim <- c(1, LENGTH)     }

  #ncpu        <- getDoParWorkers()
  calc.posvec <- ilim[1]:ilim[2]

  if(ncpu==1){

    ##--- NON-PARALLEL EXECUTION WITH A PROGRESS BAR
    length.calc.posvec <- length(calc.posvec)
    RESULTS <- rep(NA, length.calc.posvec)
    counter <- 1
    pb <- txtProgressBar(min=0, max=length.calc.posvec, style=3)
    for(pos in calc.posvec){
      setTxtProgressBar(pb, counter)
      ##-------
      if( pos>=4 & pos<=(LENGTH-3) ){
        RESULTS[counter] <- Seq2Index(query.seq=sequence[(pos-3):(pos+3)]) + 1
      }
      ##-------
      counter <- counter+1
    }
    close(pb)
    ##--- END OF NON-PARALLEL EXECUTION WITH A PROGRESS BAR

  } else {

    ##--- PARALLEL EXECUTION
    RESULTS <- foreach(pos=isplitVector(calc.posvec, chunks=ncpu),
                       .combine="c", .inorder=TRUE) %dopar% {
      row.in.par <- rep(NA, length(pos))
      counter <- 1
      for(k in pos){
        ##-------
        if( k>=4 & k<=(LENGTH-3) ){
          row.in.par[counter] <- Seq2Index(query.seq=sequence[(k-3):(k+3)]) + 1
        }
        ##-------
        counter <- counter+1
      }
      return(row.in.par)
    }
    ##--- END OF PARALLEL EXECUTION

  }

  return(RESULTS)

}
## FUNCTION ####################################################################
