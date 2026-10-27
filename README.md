## Polymoprhism pattern in *A. thaliana* genomes

This repository contains the code for the analyses in Grigoreva et al. paper
The analyses study patterns of diversity in a collection of 27 *Arabidopsis thaliana* genomes and 31 *Arabidopsis lyrata* genomes.

### 1. Whole-genome alignment using pannagram

We aligned 27 long-read *A. thaliana* genome assemblies ([source](https://www.nature.com/articles/s41588-025-02293-0)) and 31 *A. lyrata* genome assemblies ([source](https://www.ncbi.nlm.nih.gov/nuccore/CAXDWP000000000.1)) to the TAIR10 reference genome with pannagram (https://github.com/iganna/pannagram).

Script: `scripts/01_pannagram.sh`

The script runs two alignments:

- **A. thaliana only:** the 27 *A. thaliana* genomes
- **A. thaliana + A. lyrata:** the 27 *A. thaliana* genomes plus the 31 *A. lyrata* genomes

The output of the script is two .vcf files for the corresponding alignments.

### 2. ...
