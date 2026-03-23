#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=5G
#SBATCH --time=40:00:00
#SBATCH --qos="long"
#SBATCH --array=1
#SBATCH --output=/groups/nordborg/projects/genome_organization/slurm/orthofinder_nucl_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/slurm/orthofinder_nucl_%A_%a.err

ml build-env/.f2021
ml orthofinder/2.5.4-foss-2020b
ulimit -n 6500
orthofinder -f /groups/nordborg/projects/genome_organization/manuscript/03_processing/orthofinder_tair10_mn47  -d  -t 10 
