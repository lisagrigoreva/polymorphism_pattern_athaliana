### 11. Analysis of single moved genes

We identified and analysed genes that moved to a new location in *A. thaliana* in four sub-steps.

#### 11.1. Detect candidate moved genes

We plotted the positions of 1:1 orthologs between *A. thaliana* and *A. lyrata* (dot plot) and flagged genes outside syntenic blocks as candidate moved genes.

**Script:** `scripts/moved_genes_detection.Rmd`

- **Input:** 1:1 orthologous genes (step 4)
- **Output:** table of candidate moved genes in *A. thaliana*

#### 11.2. Determine the ancestral location using *C. rubella*

To build a confident set, we used *C. rubella* as an outgroup to decide whether the gene moved in *A. thaliana* or in *A. lyrata*.

**Script:** `scripts/moved_genes_ancestral_location_attribution.Rmd`

- **Input:**
  - candidate moved genes (step 11.1)
  - *A. lyrata* MN47 annotation (`.gtf`)
  - *A. thaliana*–*C. rubella* orthologs from [CapBase](https://capsella.uk/)
  - *C. rubella* annotation (`.gff3`)
- **Output:** `.bed` files with each gene and ±10 kb of flanking sequence

#### 11.3. Pairwise dot plots

We extracted the sequences in the `.bed` files from step 11.2 with [bedtools getfasta](https://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html) and built pairwise dot plots with [pannagram](https://github.com/iganna/pannagram/tree/main/docs).

```
while read chr start end name; do
  printf "%s\t%s\t%s\t%s\n" "$chr" "$start" "$end" "$name" | \
    bedtools getfasta -fi TAIR10_chr_all.fas -bed - -nameOnly -fo fasta_thaliana_transposed_genes/${name}.fa
done < thaliana_98transposed_genes_10Kbplusmin.bed
```

This steps tells us if gene moved in *A. thaliana* or in *A. lyrata*.

**Scripts:**

- `scripts/dotplot_pair.R`: *A. thaliana* vs *A. lyrata* / *A. thaliana* vs *C. rubella* / *A. lyrata* vs *C. rubella* dotplots
- `scripts/dotplots.sh`: submission of the previous script as a sbatch array
  
- **Input:** `.fasta` files of each gene with ±10 kb flanking sequence
- **Output:** dot plots (`.png`)

#### 11.4. Test and visualise diversity at ancestral and new locations

For genes confirmed as moved in *A. thaliana* (step 11.3), we visualised each move between the *A. thaliana* and *A. lyrata* genomes. We then used a χ² test to check whether genes tend to move from regions of a particular diversity level.

**Script:** `scripts/chisquare_and_vis_moved_genes.R`

- **Input:** IDs of confirmed moved genes (step 11.3), nucleotide diversity tables for *A. thaliana* and *A. lyrata* (step 5)
- **Output:** χ² test results and plots of the moves

