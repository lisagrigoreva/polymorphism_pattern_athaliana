#Count degeneracy of sites in tair10
python ./degenotate/degenotate.py  -a ../../data/tair10/annot_wo_nonnuclear.gtf  -g  $tai10_5chr  -o /groups/nordborg/user/elizaveta.grigoreva/genome_evolution_pacbio/analyses/004_polymorphism_annas_snps/all_sites_processing/4fold_sites/

#Extract 0 fold and 4 fold sites 
cat 0_degenerate_sites.bed | grep 'Chr1' | cut -f 1,3 > 0_degenerate_sites_chr1_pos.txt
cat 4_degenerate_sites.bed | grep 'Chr1' | cut -f 1,3 > 4_degenerate_sites_chr1_pos.txt

