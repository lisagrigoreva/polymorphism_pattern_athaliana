#Count degeneracy of sites in tair10
# Convert gff to gtf 
#gffread TAIR10_GFF3_genes.gff -T -o TAIR10_GFF3_genes.gtf
#grep -P '^Chr[1-5]\t' TAIR10_GFF3_genes.gtf > TAIR10_GFF3_genes_nuclear.gtf
# samtools faidx TAIR10_chr_all.fas Chr1 Chr2 Chr3 Chr4 Chr5 > TAIR10_nuclear.fas
degenotate.py  -a TAIR10_GFF3_genes_nuclear.gtf -g  TAIR10_nuclear.fas -o  /groups/nordborg/projects/genome_organization/manuscript/04_output/degenerate_sites/degenotate/

#Extract 0 fold and 4 fold sites 
# awk -F'\t' '$5 == 4 {print $1, $3}' degeneracy-all-sites.bed > 4_fold_sites_n.txt

## A. lyrata MN47 ##
#samtools faidx GCA_944990045.1_MN47_v2_genomic.fna
#cut -f1,2 GCA_944990045.1_MN47_v2_genomic.fna.fai | sort -k2,2 -nr 
#cut -f1,2 GCA_944990045.1_MN47_v2_genomic.fna.fai | sort -k2,2 -nr | head -n 9  > 8_longest_scaffolds.txt
#grep -F -f 8_longest_scaffolds.txt   GCA_944990045.1_MN47_v2_genomic.gtf > 8_longest_scaffolds.gtf
# Run degenotate
degenotate.py  -a 8_longest_scaffolds.gtf -g 8_longest_scaffolds.fas  -o  /groups/nordborg/projects/genome_organization/manuscript/04_output/degenerate_sites/degenotate/mn47
