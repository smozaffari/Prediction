 #!/bin/bash
#PBS -N HT_gtype
#PBS -l walltime=4:00:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=15gb
#PBS -e HT_gtype.err
#PBS -o HT_gtype.log
#PBS -M smozaffari@uchicago.edu

export TMPDIR=$WORKDIR
cd $PBS_O_WORKDIR
export TEMP=$WORKDIR

module load R

Rscript /group/ober-resources/users/smozaffari/Prediction/data/test/PrediXcan/Hutterite/HT_genotypescript_2.R



