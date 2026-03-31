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
orthofinder -f /groups/nordborg/projects/genome_organization/manuscript/03_processing/orthofinder_tair10_mn47 -t 10 

# Get orthologous genes
# grep -Fwf ./Orthogroups/Orthogroups_SingleCopyOrthologues.txt Athaliana_167_protein_primaryTranscriptOnly__v__Alyrata_384_v2.1.protein_primaryTranscriptOnly.tsv > one2one_orthologs.tsv
# Parse output
#awk -F'\t' '{
#    # AT gene: strip |PACid_... then strip .1/.3 etc
#    split($2, a, "|"); split(a[1], b, "."); at=b[1]
#    # AL gene: strip .t1/.t2 etc
#    split($3, c, "."); al=c[1]
#    print $1"\t"at"\t"al
#}' one2one_orthologs.tsv > one2one_genes.ts
