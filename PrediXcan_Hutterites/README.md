# PrediXcan_Hutterites

files taken from :

    plink --bfile /group/ober-resources/resources/Hutterites/PRIMAL/data-sets/qc/qc --extract rsSNPlist.txt --out qcfiles_rsids --recode 12

extracting SNPs that have rsIDs — determined from:`qc.bim` after annotated with annotation file

    grep rs annotated_qc.bim > rs_qc.bim

Extract SNPs with rsids from PRIMAL qc data

    plink  --bfile /group/ober-resources/resources/Hutterites/PRIMAL/data-sets/qc/qc --extract rsSNPlist.txt --out qcfiles_rsids --recode 12

CGI SNPs in rs ids:

    qcfiles_rsids_SNPs.map qcfiles_rsids_SNPs.ped

Extract hapmapSnps for PrediXcan:

    plink --extract hapmapSnpsCEU.list --file new2 --out qcfiles_rsids_hapmapSNPs --recode 12    

Unique SNP identifiers by combining rs id + location

    plink --file qcfiles_rsids_hapmapSNPs --out test_recode_all --recode A --recode-allele recode.txt

Separate dosage file by chromosome

    bychrom.sh
  
Separate SNPinfo.bim and list by chromosome:

    bychrom_list.pl

Make dosage files:

    makedosagefiles.R

Run PrediXcan:

    runPrediXcan.sh

