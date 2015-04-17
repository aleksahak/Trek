################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
Seq2Index <- function(query.seq=NULL){

  if( query.seq[1]=="" ){
    return(0)
  } else {
    nch <- length(query.seq)
    # Last character:
    last.char <- query.seq[nch]
    # Updating the string into the one without the last character:
    if(nch==1){
      query.seq <- ""
    } else {
      query.seq <- query.seq[1:(nch-1)]
    }

    return(  4*Seq2Index(query.seq=query.seq) +
               (match(last.char, c("A","C","G","T"))-1)  )

  }

}
## FUNCTION ####################################################################
