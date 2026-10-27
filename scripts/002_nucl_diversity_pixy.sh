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
#pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats pi --sites_file ${DATA}/04_output/degenerate_sites/degenotate_thaliana/4_fold_sites_thaliana.txt  --populations ${DATA}/01_data/popcode/pop_file_thal.txt --output_folder ${DATA}/04_output/002_diversity_thaliana/ --output_prefix 4fol_sites_thal_27g_tair10_based --n_cores 60 --window_size 1 
# Diversity in 1-1 orthologous genes 
pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats pi --sites_file ${DATA}/04_output/degenerate_sites/degenotate_thaliana/4_fold_sites_thaliana.txt --populations ${DATA}/01_data/popcode/pop_file_thal.txt --output_folder ${DATA}/04_output/002_diversity_thaliana/ --output_prefix 1to1_orth_genes_thal_27g_tair10_based --n_cores 60 --window_size 1
# Diversity in thaliana genes 
#pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats pi --sites_file ${DATA}/01_data/tair10/genes.bed --populations ${DATA}/01_data/popcode/pop_file_thal.txt --output_folder ${DATA}/04_output/002_diversity_thaliana/ --output_prefix genes_thal_27g_tair10_based --n_cores 60 --window_size 1
# Diversity in thaliana everywhere (gene+intergenic regions)
#pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats pi --populations ${DATA}/01_data/popcode/pop_file_thal.txt --output_folder ${DATA}/04_output/002_diversity_thaliana/ --output_prefix all_genes_and_intergenic_thal_27g_tair10_based --n_cores 60 --window_size 1
# Diversity in lyrata
#pixy --vcf ${DATA}/04_output/pannagram_lyr_31g_mn47/features/vcf/alyr_31_allchr_all_sites.vcf.gz --stats pi --sites_file ${DATA}/04_output/degenerate_sites/degenotate_lyrata_mn47/4fold_sites_renamed_chr.txt  --populations ${DATA}/01_data/pop_file_lyrata.txt --output_folder ${DATA}/04_output/002_diversity_lyrata/ --output_prefix 4fol_sites_lyr_31g_mn47_based --n_cores 60 --window_size 1
# Divergence in lyrata and thaliana
#pixy --vcf ${DATA}/04_output/001_pannagram_31_lyr_27thal_tair10based/features/converted_vcf/all_chr_tair10_27gthal_31glyr_miss90_invarandsnps.vcf.gz  --stats pi dxy --sites_file ${DATA}/04_output/degenerate_sites/degenotate_thaliana/4_fold_sites_thaliana.txt  --populations ${DATA}/01_data/popcode/lyrata_thaliana_popcode.txt --output_folder ${DATA}/04_output/002_divergence_diversity_thal_lyr/ --output_prefix 4fol_sites_lyr_31g_tair10_based --n_cores 60 --window_size 1
# Fst in thaliana 
#pixy --vcf ${DATA}/04_output/001_pannagram_27_genomes/features/converted_vcf/all_chr_tair10_27g_miss90_invarandsnps.vcf.gz --stats fst  --populations ${DATA}/01_data/popcode/pop_file_thal_countries.txt --output_folder ${DATA}/04_output/003_fst_27genomes/ --output_prefix fst_thal_27g_tair10_based --n_cores 60 --window_size 1
