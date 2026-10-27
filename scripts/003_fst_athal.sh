#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem-per-cpu=3G
#SBATCH --time=02:00:00
#SBATCH --partition=m
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/manuscript/logs/pixy_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/manuscript/logs/pixy_%A_%a.err

# Paths
BASE="/groups/nordborg/projects/genome_organization"
DATA="${BASE}/manuscript"

# Fst in A thaliana
pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats fst  --populations ${DATA}/01_data/popcode/pop_file_thal_countries.txt --output_folder ${DATA}/04_output/003_fst_27genomes/ --output_prefix fst_thal_27g_tair10_based --n_cores 60 --window_size 500000
