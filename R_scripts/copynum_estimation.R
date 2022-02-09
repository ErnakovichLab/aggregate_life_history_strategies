#copynum_estimation.R
## automated copy number estimation R script to accompany copynum_estimation.sh
## Steven Kembel skembel@uoregon.edu
## depends on R libraries picante, phangorn, ape being installed

arg <- commandArgs(TRUE)
workDir <- arg[1]
refDir <- arg[2]
inseqs <- arg[3]

#setwd(workDir)

require(picante)
#, lib.loc="/Library/Frameworks/R.framework/Versions/2.12/Resources/library")
require(phangorn)
#, lib.loc="/Library/Frameworks/R.framework/Versions/2.12/Resources/library")

load(paste(refDir, "copynum_estimation_workspace.RData", sep="/"))

intree <- read.tree(paste(workDir, "/pplacer/", inseqs, ".aligned.masked.tog.tre", sep="" ))

intree <- multi2di(intree)

intree <- addRefLabels(reftree.phyEstRef, intree)

copynum.est <- phyEstimateFast(reftree.phyEstRef, intree)

save.image(file=paste(workDir, "copynum.est.RData", sep="/"))
write.csv(copynum.est, paste(workDir, "copynum.est.csv", sep="/"))
