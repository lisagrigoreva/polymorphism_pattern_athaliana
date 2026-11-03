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
