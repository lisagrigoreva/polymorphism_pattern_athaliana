# Select only genes
awk -F'\t' '$3 == "gene"' TAIR10_GFF3_genes.gff > genes_only.gff
# Convert to bed 
gff2bed < genes_only.gff > genes.bed
# get gene sequences
#while read chr start end name score strand; do
#     samtools faidx TAIR10_nuclear.fas "${chr}:$((start+1))-${end}" | \
#     sed "1s/.*/>$name/"
#done < genes.bed > all_genes.fasta
# Run simsearch
#simsearch -query_seqs /groups/nordborg/projects/genome_organization/manuscript/01_data/tair10/all_genes.fasta -target_path /groups/nordborg/projects/genome_organization/manuscript/01_data/31_lyrata_genomes/genomes_8scaff/ -out /groups/nordborg/projects/genome_organization/manuscript/04_output/simsearch_athal_31lyr/ -sim 85 -cov 90
# Simsearch capsella vs thaliana genes 
simsearch -query_seqs /groups/nordborg/projects/genome_organization/manuscript/01_data/tair10/all_genes.fasta  -target_path /groups/nordborg/projects/genome_organization/manuscript/04_output/simsearch_athal_crubella  -out /groups/nordborg/projects/genome_organization/manuscript/04_output/simsearch_athal_crubella  -sim 85 -cov 90
# Simsearch capsella vs alyrata 
simsearch -query_seqs /groups/nordborg/projects/genome_organization/manuscript/01_data/mn47/fasta_genes_mn47/mn47_genes.fasta  -target_path /groups/nordborg/projects/genome_organization/manuscript/04_output/simsearch_alyr_crubella  -out /groups/nordborg/projects/genome_organization/manuscript/04_output/simsearch_athal_crubella  -sim 85 -cov 90

