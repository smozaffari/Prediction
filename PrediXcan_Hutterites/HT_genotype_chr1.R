print("Reading files")
bim <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/ann_chr1.bim")
IDxSNP2 <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/chr1.ped")
ID <- IDxSNP2[,2]
IDxSNP <- IDxSNP2[,-c(1:6)]
SNPxID <- t(IDxSNP)
SNPlist <- read.table("/group/ober-resources/users/smozaffari/Prediction/data/test/chr1_rslist.txt")
#ID <- read.table("/group/im-lab/nas40t2/hwheeler/cross-tissue/gtex-genotypes/GTEx_Analysis_2014-06-13.hapmapSnpsCEU.ID.list")
#IDs already included in ped file 

print("Merging files")
colnames(SNPxID) <- ID

tab <- cbind(SNPlist, SNPlist, bim$V4, bim$V5, bim$V6, "NA", SNPxID)


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

