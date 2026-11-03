### 4. Identify 1:1 orthologs between *A. thaliana* and *A. lyrata*

We estimated divergence between the two species in 1:1 orthologous genes. We identified these genes with the `simsearch` mode of [pannagram](https://github.com/iganna/pannagram).

**Script:** `scripts/04_simsearch.sh`

- **Input:** `.fasta` of all TAIR10 gene sequences
- **Output:** 1:1 orthologous gene pairs between *A. thaliana* and *A. lyrata* (≥85% similarity, ≥90% coverage)

We then process the `simsearch` output in R into a table of matching gene coordinates in the two genomes.

**Script:** `scripts/simsearch_create_gene_table.Rmd`

- **Input:** `simsearch` output from step 4
- **Output:** table of 1:1 orthologs with coordinates in both genomes
