################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
getOUT <- function(LENGTH=seq$length, mr=mr){

  return( c(
    "HEADER: **********************************************************************",
    "HEADER: POS - position in the provided sequence.",
    "HEADER: SEQ - the sequence context at the position.",
    "HEADER: BASE - the nucleobase at the position (wt).",
    "HEADER: k1 - the mutation rate constant for wt->b2 in byr-1.",
    "HEADER: k2 - the mutation rate constant for wt->b3 in byr-1.",
    "HEADER: k3 - the mutation rate constant for wt->b4 in byr-1.",
    "HEADER: q1 - the length of the sequence context while retrieving k1.",
    "HEADER: q2 - the length of the sequence context while retrieving k2.",
    "HEADER: q3 - the length of the sequence context while retrieving k3.",
    "HEADER: b2, b3 and b4 in the explanation of k1, k2 and k3 are the bases",
    "HEADER: other than the existing BASE (wt) in an alphabetical order, i.e.",
    "HEADER: if BASE=A, k1, k2 and k3 are for the A->C, A->G, A->T mutations;",
    "HEADER: if BASE=C, k1, k2 and k3 are for the C->A, C->G, C->T mutations;",
    "HEADER: if BASE=G, k1, k2 and k3 are for the G->A, G->C, G->T mutations;",
    "HEADER: if BASE=T, k1, k2 and k3 are for the T->A, T->C, T->G mutations.",
    "HEADER: q1, q2 and q3 show the qualities of sequence-context accounting.",
    "HEADER: **********************************************************************",
    "HEADER: POS SEQ BASE      k1                k2                k3     q1 q2 q3",
    paste("DATA:",1:LENGTH, mr, sep=" "),
    "HEADER: **********************************************************************")
  )

}
## FUNCTION ####################################################################
