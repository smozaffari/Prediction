 #!/bin/bash
#PBS -N annotate_bim
#PBS -l walltime=2:00:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=15gb
#PBS -e annotate_bim.err
#PBS -o annotate_bim.log
#PBS -M smozaffari@uchicago.edu

export TMPDIR=$WORKDIR
cd $PBS_O_WORKDIR
export TEMP=$WORKDIR

perl /group/ober-resources/users/smozaffari/Prediction/data/test/PrediXcan/Hutterite/annotate.pl qcfiles_rsids_hapmapSNPs.map



