#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=50:00:00
#SBATCH --partition=m
#SBATCH --qos="long"
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/08_manuscripts/logs/pannagram_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/08_manuscripts/logs/pannagram_%A_%a.err

# Activate environment
#conda activate pannagram

# Paths
BASE="/groups/nordborg/projects/genome_organization"
DATA="${BASE}/manuscript"

# Run pannagram
#pannagram -cores 10 -path_in ${DATA}/01_data/27_genomes/ -path_out  ${DATA}/04_output/pannagram_thal_27g_tair10 -ref "TAIR10" -nchr 5 -nchr_ref 5
# get features 
features -path_project ${DATA}/04_output/pannagram_thal_27g_tair10 -ref 'TAIR10' -seq -cores 10
