#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=3G
#SBATCH --time=02:00:00
#SBATCH --partition=m
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.err

# Activate environment
#conda activate pixy

# Paths
BASE="/groups/nordborg/projects/genome_organization"
DATA="${BASE}/manuscript"

## Diversity in thaliana in 4 fold sites in 1-1 genes 
pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats pi --sites_file ${DATA}/04_output/degenerate_sites/degenotate_thaliana/4_fold_sites_in_1to1genes_thaliana.txt  --populations ${DATA}/01_data/popcode/pop_file_thal.txt --output_folder ${DATA}/04_output/002_diversity_thaliana/ --output_prefix 4fol_sites_thal_27g_tair10_based_1to1_genes --n_cores 60 --window_size 1
