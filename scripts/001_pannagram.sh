#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=3G
#SBATCH --time=05:00:00
#SBATCH --partition=m
#SBATCH --qos="long"
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/manuscript/logs/pannagram_%A_%a.err

# Activate environment
#conda activate pannagram

## Pannagram TAIR10 reference, 27 thaliana genomes ##
# Paths
DIR="/groups/nordborg/projects/genome_organization/manuscript"
# Run pannagram
#pannagram -cores 10 -path_in ${DIR}/01_data/27_genomes/ -path_out ${DIR}/04_output/001_pannagram_27_genomes -ref "TAIR10" -nchr 5 -nchr_ref 5 && 
# get features 
#features -path_project ${DIR}/04_output/001_pannagram_27_genomes -ref 'TAIR10' -blocks -seq -snp -cores 10

## Pannagram MN47 reference, 31 lyr genomes ##
#pannagram -cores 10 -path_in ${DIR}/01_data/31_lyrata_genomes/genomes_8scaff/ -path_out ${DIR}/04_output/001_pannagram_31_lyrata_genomes -ref "GCA_944990045.1_MN47_v2_8scaff" -nchr 8 -nchr_ref 8 &&
# get features
#features -path_project ${DIR}/04_output/001_pannagram_31_lyrata_genomes -ref 'GCA_944990045.1_MN47_v2_8scaff' -blocks -seq -snp -cores 10 &&

## Pannagram MN47 reference, 31 lyr genomes, 27 thaliana genomes  ##
#pannagram -cores 10 -path_in ${DIR}/04_output/001_pannagram_31_lyr_27thal_tair10based/ -path_out ${DIR}/04_output/001_pannagram_31_lyr_27thal_tair10based -ref "TAIR10" -nchr 5 -nchr_ref 5 &&
# get features
features -path_project ${DIR}/04_output/001_pannagram_31_lyr_27thal_tair10based -ref 'TAIR10' -blocks -seq -snp -cores 10
