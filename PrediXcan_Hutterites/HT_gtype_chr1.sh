 #!/bin/bash
#PBS -N HT_gtype_chr1
#PBS -l walltime=2:00:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=15gb
#PBS -e HT_gtype_chr1.err
#PBS -o HT_gtype_chr1.log
#PBS -M smozaffari@uchicago.edu

export TMPDIR=$WORKDIR
cd $PBS_O_WORKDIR
export TEMP=$WORKDIR

module load R

Rscript /group/ober-resources/users/smozaffari/Prediction/data/test/PrediXcan/Hutterite/HT_genotype_chr1.R



