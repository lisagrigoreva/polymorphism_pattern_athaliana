## Polymoprhism pattern in *A. thaliana* genomes

This repository contains the code for the analyses in Grigoreva et al. paper
The analyses study patterns of diversity in a collection of 27 *Arabidopsis thaliana* genomes and 31 *Arabidopsis lyrata* genomes.

### 1. Whole-genome alignment using pannagram

We aligned 27 long-read *A. thaliana* genome assemblies ([source](https://www.nature.com/articles/s41588-025-02293-0)) and 31 *A. lyrata* genome assemblies ([source](https://www.ncbi.nlm.nih.gov/nuccore/CAXDWP000000000.1)) to the TAIR10 reference genome with pannagram (https://github.com/iganna/pannagram).

**Script:** `scripts/01_pannagram.sh`

- **Input:** genome assemblies (FASTA), all stored in one folder
- **Output:** reference-based multiple sequence alignment against TAIR10 as a reference

The script runs two alignments:

- **A. thaliana only:** the 27 *A. thaliana* genomes
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
### 3. Extract 4-fold degenerate sites from .vcf file 
The diversity was measured in 4-fold degenerate (neutral) sites. In order to obtain these sites we used degenotate (https://github.com/harvardinformatics/degenotate) and annotation for TAIR10 and MN47. 

**Script:** `scripts/03_degeannotate.sh`

- **Input:** `.gtf` annotation and `.fasta` file for each genome 
- **Output:** `.bed` file with sites degeneracy.

### 4. Calculate nucleotide diversity (pi) in for *A. thaliana* and nucleotide divergence between *A. thaliana* and *A. lyrata*


