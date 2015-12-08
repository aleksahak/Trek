################################################################################
#//    Aleksandr B. Sahakyan (aleksahak [at] cantab.net), Cambridge 2015     \\#
## FUNCTION ####################################################################
getSTART <- function(){

  return( c(
    "HEADER: **********************************************************************",
    "HEADER: POS - position in the provided sequence.",
    "HEADER: SEQ - the sequence context at the position.",
    "HEADER: BASE - the nucleobase at the position (b1).",
    "HEADER: k1 - the core substitution rate constant for b1->b2 in byr-1.",
    "HEADER: k2 - the core substitution rate constant for b1->b3 in byr-1.",
    "HEADER: k3 - the core substitution rate constant for b1->b4 in byr-1.",
    "HEADER: q1 - the length of the sequence context while retrieving k1.",
    "HEADER: q2 - the length of the sequence context while retrieving k2.",
    "HEADER: q3 - the length of the sequence context while retrieving k3.",
    "HEADER: b2, b3 and b4 in the explanation of k1, k2 and k3 are the bases",
    "HEADER: other than the existing BASE (b1) in an alphabetical order, i.e.",
    "HEADER: if BASE=A, k1, k2 and k3 are for the A->C, A->G, A->T substitution;",
    "HEADER: if BASE=C, k1, k2 and k3 are for the C->A, C->G, C->T substitution;",
    "HEADER: if BASE=G, k1, k2 and k3 are for the G->A, G->C, G->T substitution;",
    "HEADER: if BASE=T, k1, k2 and k3 are for the T->A, T->C, T->G substitution.",
    "HEADER: q1, q2 and q3 show the qualities of sequence-context accounting.",
    "HEADER: **********************************************************************",
    "HEADER: POS SEQ BASE      k1                k2                k3      q1 q2 q3",
    "HEADER: **********************************************************************")
  )
    
}
## FUNCTION ####################################################################
