print("Reading bim")
bim <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/SNPinfo.bim")
print("Reading IDxSNP")
#IDxSNP2 <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/qcfiles_rsids_hapmapSNPs.ped")
IDxSNP <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/IDxSNP.ped")
#print ("getting IDs")
#ID <- IDxSNP2[,2]
#print ("removing first 6 columns\n")
#IDxSNP <- IDxSNP2[,-c(1:6)]
print ("tranposing matrix")
SNPxID <- t(IDxSNP)
print ("reading SNP list")
SNPlist <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/SNPlist_hapmap_rsids.txt")
print ("getting IDs")
ID <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/HUTTsamples.txt")

print("Merging files")
colnames(SNPxID) <- ID

tab <- cbind(SNPlist, SNPlist, bim$V4, bim$V5, bim$V6, bim$V7, SNPxID)

print ("Adding column names")
colnames(tab)[1] <- "SNP"
colnames(tab)[2] <- "SNP"
colnames(tab)[3] <- "pos"
colnames(tab)[4] <- "Ref_allele"
colnames(tab)[5] <- "Dos_allele"
colnames(tab)[6] <- "MAF"


spt <- split(tab, bim$V1)
print("Writing Files")
lapply(names(spt), function(x){write.table(spt[[x]], file = paste("HUTT_chr", x,".dos", sep = ""), quote = F, row.names = F, col.names = F)})

write.table(ID, "HUTTsamples.txt", col.names = F, row.names = F, quote = F)

print("Gunzipping files")
system("gzip HUTT_chr*")

