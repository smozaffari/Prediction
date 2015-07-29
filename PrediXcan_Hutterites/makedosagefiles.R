args <- commandArgs(trailingOnly=TRUE)
x <- args[1];
print(paste("Input: Chromosome", x, sep = " "))
print("Reading bim")
bim <- read.table(paste("/group/ober-resources/users/smozaffari/Prediction/data/test/bychromosome/chr",x ,".SNPinfo.txt", sep = ""))
print("Reading IDxSNP")
IDxSNP <- read.table(paste("/group/ober-resources/users/smozaffari/Prediction/data/test/bychromosome/chr", x,".ped", sep=""))

print ("tranposing matrix")
SNPxID <- t(IDxSNP)
print ("reading SNP list")
SNPlist <- read.table(paste("/group/ober-resources/users/smozaffari/Prediction/data/test/bychromosome/chr",x,".SNPlist.txt", sep = ""))
print ("getting IDs")
ID <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/HUTTsamples.txt")

print("Merging files")
colnames(SNPxID) <- ID$V1

tab <- cbind(SNPlist, SNPlist, bim$V4, bim$V5, bim$V6, bim$V7, SNPxID)

print ("Adding column names")
colnames(tab)[1] <- "SNP"
colnames(tab)[2] <- "SNP"
colnames(tab)[3] <- "pos"
colnames(tab)[4] <- "Ref_allele"
colnames(tab)[5] <- "Dos_allele"
colnames(tab)[6] <- "MAF"


#spt <- split(tab, bim$V1)
print("Writing Files")
#lapply(names(spt), function(x){write.table(spt[[x]], file = paste("HUTT_chr", x,".dos", sep = ""), quote = F, row.names = F, col.names = F)})

write.table(tab, paste("HUTT_chr", x, ".dos", sep = ""), row.names = F, col.names = F, quote = F);

write.table(ID, paste("HUTTsamples_chr",x ,".txt", sep = ""), col.names = F, row.names = F, quote = F)
print("Gunzipping files")
system(paste("gzip HUTT_chr", x,".dos", sep = ""))

