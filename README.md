## Polymoprhism pattern in *A. thaliana* genomes

This repository contains the code for the analyses in Grigoreva et al. paper
The analyses study patterns of diversity in a collection of 27 *Arabidopsis thaliana* genomes and 31 *Arabidopsis lyrata* genomes.

### 1. Whole-genome alignment using pannagram

We aligned 27 long-read *A. thaliana* genome assemblies ([Igolkina et.al, 2025](https://www.nature.com/articles/s41588-025-02293-0)) and 31 *A. lyrata* genome assemblies ([source](https://www.ncbi.nlm.nih.gov/nuccore/CAXDWP000000000.1)) to the TAIR10 reference genome and and to the MN47 reference genome with pannagram (https://github.com/iganna/pannagram).

**Script:** `scripts/01_pannagram.sh`

- **Input:** genome assemblies (FASTA), all stored in one folder
- **Output:** reference-based multiple sequence alignment against TAIR10 as a reference or MN47 for A.lyrata genomes

The script runs three alignments:

- **A. thaliana only:** the 27 *A. thaliana* genomes
- **A. lyrata only:** the 31 *A. lyrata* genomes
- **A. thaliana + A. lyrata:** the 27 *A. thaliana* genomes plus the 31 *A. lyrata* genomes

Each run creates its own output folder. The alignment used in the next steps is in `features/msa/`.

### 2. Convert pannagram alignment to VCF (variable + non variable sites)

**Script:** `scripts/h5_to_vcf.py`

- **Input:** `.h5` files from `features/msa/` (`ref_*.h5` with positions, `seq_*.h5` with nucleotides)
- **Output:** one pseudo-VCF file per chromosome

**Requirements:** `h5py`. On the cluster, example to load it:

```bash
ml build-env/f2022 h5py/3.8.0-foss-2022b
```

**Usage:**

```bash
python scripts/02_h5_to_vcf.py \
    --ref features/msa/ref_1_1_TAIR10.h5 \
    --seq features/msa/seq_1_1_TAIR10.h5 \
    --out chr1.vcf \
    --chrom Chr1
```
### 3. Identify 4-fold degenerate sites

In this study we measured diversity at 4-fold degenerate sites, which are treated as neutral. We identified these sites with [degenotate](https://github.com/harvardinformatics/degenotate), using the TAIR10 (*A. thaliana*) and MN47 (*A. lyrata*) annotations.

**Script:** `scripts/03_degeannotate.sh`

- **Input:** genome `.fasta` and annotation `.gtf` for each reference
- **Output:** `.bed` file with the degeneracy of each coding site

### 4. Identify 1:1 orthologs between *A. thaliana* and *A. lyrata*

We estimated divergence between the two species in 1:1 orthologous genes. We identified these genes with the `simsearch` mode of [pannagram](https://github.com/iganna/pannagram).

**Script:** `scripts/04_simsearch.sh`

- **Input:** `.fasta` of all TAIR10 gene sequences
- **Output:** 1:1 orthologous gene pairs between *A. thaliana* and *A. lyrata* (≥85% similarity, ≥90% coverage)

We then process the `simsearch` output in R into a table of matching gene coordinates in the two genomes.

**Script:** `scripts/simsearch_create_gene_table.Rmd`

- **Input:** `simsearch` output from step 4
- **Output:** table of 1:1 orthologs with coordinates in both genomes

### 5. Nucleotide diversity (π) and divergence (d<sub>XY</sub>)

We used [pixy](https://github.com/ksamuk/pixy) ([Korunes & Samuk, 2021](https://pmc.ncbi.nlm.nih.gov/articles/PMC8044049/)) to calculate nucleotide diversity (π) within *A. thaliana* and *A. lyrata* and divergence (d<sub>XY</sub>) between *A. thaliana* and *A. lyrata*, both estimated in 4-fold degenerate sites.

**Script:** `scripts/05_nucl_diversity_pixy.sh`

- **Input:** all-sites `.vcf` (step 2), 4-fold degenerate sites `.bed` (step 3), 1:1 ortholog coordinates (step 4), and a population file (`.txt`: sample ID, population)
- **Output:** pixy π and d<sub>XY</sub> tables

In order to define the peri-centromeric boundaries we use histone states from (([Shukla et.al, 2026] (https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1012015)).

We assigned a chromatin state to each genomic window based on the percentage of the window covered by heterochromatin.
**Script:**  `scripts/histone_states_assignment.Rmd`
Diversity pattern visualization:
**Script:** `scripts/diversity_within_27_athaliana_and31_lyrata.Rmd`
Divergence patterns visualization:
**Script:** `scripts/diversity_divergence_thaliana_lyrata.Rmd`

### 6. Mutation rate estimation

We estimated mutation rates using data from mutation accumulation lines in *A. thaliana* ([Weng et al., 2019, *Genetics*](https://academic.oup.com/genetics/article/211/2/703/5931174)). We used two supplementary files from that paper:

- `Shared_mutations.csv`: mutations shared between multiple lines
- `Unique_mutations.csv`: mutations found in only one line

We followed the approach described in the Methods section of that paper and calculated mutation rates for each genomic context (genes, TEs) and for the 1:1 orthologous genes from step 4.

**Script:** `scripts/mutation_rate_analysis.Rmd` 

- **Input:** `Shared_mutations.csv`, `Unique_mutations.csv`, genome annotation, 1:1 ortholog coordinates (step 4)
- **Output:** mutation rates per genomic context and visualization of the mutation rates

### 7. Recombination rate analysis (cM/Mb)

To build a recombination map and calculate recombination rates (cM/Mb), we used the male and female crossover data (Supplementary Data 1) from [Lian et al., 2022](https://doi.org/10.1038/s41467-022-31509-8).

**Script:** `scripts/recombination_rates_analysis.Rmd`

- **Input:**
  - male crossovers: `4314_ABCDEF.final.snp.ABEF.phase_v9.2.7.refinedCOs.hap.male.COs_freq_rand_chr.fl3.w1000s50.txt`
  - female crossovers: `4314_ABCDEF.final.snp.ABEF.phase_v9.2.7.refinedCOs.hap.female.COs_freq_rand_chr.fl3.w1000s50.txt`
- **Output:** recombination rate in non-overlapping windows (cM/Mb, mean of male and female)

### 8. Dn/Ds estimates

**Script:** `scripts/X.py`

- **Input:**
- **Output:** d<sub>N</sub>/d<sub>S</sub> for every gene
- 
d<sub>N</sub>/d<sub>S</sub> patterns visualization:
Visualization of d<sub>N</sub>/d<sub>S</sub>  pattern
**Script:** `scripts/dnds_vis.Rmd`

### 9. Background selection

We estimated the effect of background selection on nucleotide diversity using the approach of [Murphy et al., 2023](https://elifesciences.org/articles/76065).

**Script:** `scripts/X.py`

- **Input:**
  - nucleotide diversity (π) in *A. thaliana* (step 5)
  - d<sub>N</sub>/d<sub>S</sub> estimates
  - 0-fold and 4-fold degenerate sites (step 3)
  - recombination map (step 7)
- **Output:** expected nucleotide diversity under background selection, using the best-fitting selection parameters

Visualization of Background selection pattern
**Script:** `scripts/background_selection_pattern.Rmd`
  
### 10. Expression and enrichment analysis 
Expression of 27 *A. thaliana* genomes was taken from ([Igolkina et.al, 2025](https://www.nature.com/articles/s41588-025-02293-0)) ([NCBI](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE226691GSE226691_TPMs.4_tissues.Araport11_annotation.bed.gz))
Enrichment is done by ([clusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html))
**Script:** `scripts/expression_and_enrichment_analysis.Rmd`

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






