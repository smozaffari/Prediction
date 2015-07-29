#!/bin/bash
#PBS -N runPrediXcan
#PBS -l walltime=2:00:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=15gb
#PBS -e runPrediXcan.err
#PBS -o runPrediXcan.log
#PBS -M smozaffari@uchicago.edu

export TMPDIR=$WORKDIR
cd $PBS_O_WORKDIR
export TEMP=$WORKDIR

module load R
module load python


python /group/ober-resources/users/smozaffari/Prediction/data/test/PrediXcan/Software/predict_gene_expression.py --dosages dosagefiles --dosages_prefix HUTT_chr --weights /group/ober-resources/users/smozaffari/Prediction/data/test/DGN-WB_0.5.db  --output DGN_WB_Hutterites


