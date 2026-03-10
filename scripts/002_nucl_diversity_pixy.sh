#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
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

# Diversity in thaliana
pixy --vcf ${DATA}/04_output/pannagram_thal_27g_tair10/features/vcf/athal_allchr_all_sites.vcf.gz --stats pi --sites_file ${DATA}/01_data/4fold_thal.bed  --populations ${DATA}/01_data/pop_file_thal.txt --output_folder ${DATA}/04_output/002_div_thal_lyr/ --output_prefix 4fol_sites_thal_27g_tair10_based --n_cores 60 --window_size 1
# Diversity in lyrata
pixy --vcf ${DATA}/04_output/pannagram_lyr_31g_mn47/features/vcf/alyr_31_allchr_all_sites.vcf.gz --stats pi --sites_file ${DATA}/01_data/4_fold_lyr.txt  --populations ${DATA}/01_data/pop_file_lyrata.txt --output_folder ${DATA}/04_output/002_div_thal_lyr/ --output_prefix 4fol_sites_lyr_31g_mn47_based --n_cores 60 --window_size 1
