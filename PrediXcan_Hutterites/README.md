###To make original files

files taken from :

    plink --bfile /group/ober-resources/resources/Hutterites/PRIMAL/data-sets/qc/qc --extract rsSNPlist.txt --out qcfiles_rsids --recode 12

extracting SNPs that have rsIDs — determined from:`qc.bim` after annotated with annotation file

    grep rs annotated_qc.bim > rs_qc.bim
    
also extract hapmapSNPs used, given in PrediXcan source: `hapmapSnpsCEU.list`

    plink --file qcfiles_rsids --extract hapmapSnpsCEU.list --out qcfiles_rsids_hapmapSNPs --recode12

update .bim file and run annotate.sh
