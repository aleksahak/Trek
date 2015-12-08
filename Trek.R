################################################################################
# If nCPU>1, requires the libraries "doMC", "foreach" and "itertools".         #
# If not already installed in R, you can install those by typing:              #
# install.packages(c("doMC", "foreach" and "itertools"))                       #
################################################################################
load("Trek.lib")
Trek(FastaFile= "test.fasta", 
     OutFile  = "out.txt",
     MutRates = "sym", # "nosym"
     nCPU     = 1)
################################################################################
