 #!/bin/bash
#PBS -N splitchrom
#PBS -l walltime=4:00:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=15gb
#PBS -e split.chrom.err
#PBS -o split.chrom.log
#PBS -M smozaffari@uchicago.edu

export TMPDIR=$WORKDIR
cd $PBS_O_WORKDIR
export TEMP=$WORKDIR

perl /group/ober-resources/users/smozaffari/Prediction/data/test/PrediXcan/Hutterite/bychrom.pl





