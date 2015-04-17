################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
getBaseAfterMut <- function(BaseBeforeMut="A", variant=1){

  if(BaseBeforeMut=="A"){
    BaseAfterMut <- c("C","G","T")[variant]
  } else if (BaseBeforeMut=="G"){
    BaseAfterMut <- c("A","C","T")[variant]
  } else if (BaseBeforeMut=="T"){
    BaseAfterMut <- c("A","C","G")[variant]
  } else if (BaseBeforeMut=="C"){
    BaseAfterMut <- c("A","G","T")[variant]
  }

  return(BaseAfterMut)

}
## FUNCTION ####################################################################
