#!/bin/bash
#SBATCH --job-name=dotplots
#SBATCH --mem=30G
#SBATCH --time=03:00:00
#SBATCH --output=logs/%A_%a.out
set -euo pipefail

BASE=/groups/nordborg/projects/genome_organization/manuscript/04_output/syntenic_and_tranposed_genes
RSCRIPT=/groups/nordborg/projects/genome_organization/manuscript/polymorphism_pattern_athaliana/scripts/dotplot_pair.R
THAL=fasta_thaliana_transposed_genes
LYR=fasta_lyrata_transposed_genes
CAPS=fasta_crubella_transposed_genes
OUT=dotplots_thaliana_lyrata_capsella_2

cd "$BASE"

# Get genes transposed
#ls fasta_thaliana_transposed_genes | sed 's/\.fa$//' > genes.txt
# Run by SLURM: one gene per task, all three pairs
gene=$(sed -n "${SLURM_ARRAY_TASK_ID}p" genes.txt)
echo "Gene: $gene"

Rscript $RSCRIPT $gene $THAL $LYR  $OUT thal_vs_lyr
Rscript $RSCRIPT $gene $THAL $CAPS $OUT thal_vs_caps
Rscript $RSCRIPT $gene $LYR  $CAPS $OUT lyr_vs_caps
