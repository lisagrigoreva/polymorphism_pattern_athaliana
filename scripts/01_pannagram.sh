#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=5G
#SBATCH --time=20:00:00
#SBATCH --partition=m
#SBATCH --qos="long"
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.err

# Activate environment
conda activate pannagram

## Pannagram TAIR10 reference, 27 thaliana genomes ##
# Paths
DIR="/groups/nordborg/projects/genome_organization/manuscript"
# Run pannagram 
pannagram -cores 10 -path_in ${DIR}/01_data/27_genomes/ -path_out ${DIR}/04_output/pannagram_27_genomes -ref "TAIR10" -nchr 5 -nchr_ref 5 
# get features
features -path_project ${DATA}/04_output/pannagram_thal_27g_tair10 -ref 'TAIR10' -seq -cores 10

## Pannagram TAIR10 reference, 31 lyr genomes and 27 thaliana genomes##
pannagram -cores 10 -path_in ${DIR}/04_output/pannagram_31_lyr_27thal_tair10based/thal_and_lyr_genomes -path_out ${DIR}/04_output/pannagram_31_lyr_27thal_tair10based -ref "TAIR10" -nchr 5 -nchr_ref 5 
# get features
features -path_project ${DATA}/04_output/pannagram_31_lyr_27thal_tair10based -ref 'TAIR10' -seq -cores 10

## Pannagram MN47 reference, 31 lyr ##
pannagram -cores 10 -path_in ${DIR}/01_data/31_lyrata_genomes/genomes_8scaff/fasta -path_out ${DIR}/04_output/pannagram_lyr_31g_mn47 -ref "MN47v2" -nchr 8 -nchr_ref 8 &&
# get features
features -path_project ${DIR}/04_output/pannagram_lyr_31g_mn47 -ref 'MN47v2' -blocks -seq -snp -cores 1
