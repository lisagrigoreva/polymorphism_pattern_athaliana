## Polymoprhism pattern in *A. thaliana* genomes

This repository contains the code for the analyses in Grigoreva et al. paper
The analyses study patterns of diversity in a collection of 27 *Arabidopsis thaliana* genomes and 31 *Arabidopsis lyrata* genomes.

### 1. Whole-genome alignment using pannagram

We aligned 27 long-read *A. thaliana* genome assemblies ([source](https://www.nature.com/articles/s41588-025-02293-0)) and 31 *A. lyrata* genome assemblies ([source](https://www.ncbi.nlm.nih.gov/nuccore/CAXDWP000000000.1)) to the TAIR10 reference genome and and to the MN47 reference genome with pannagram (https://github.com/iganna/pannagram).

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

Diversity pattern visualization: `scripts/diversity_within_27_athaliana_and31_lyrata.Rmd`






