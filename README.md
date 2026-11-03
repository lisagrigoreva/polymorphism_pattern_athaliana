# Polymorphism patterns in *A. thaliana* genomes

This repository contains the code for the analyses in **Grigoreva et al. (year), *Journal*. DOI: xxx**

We use publicly available genome assemblies — 27 *Arabidopsis thaliana* and
31 *Arabidopsis lyrata* — to characterise genome-wide patterns of nucleotide
diversity and divergence, to test the influence of mutation rate and background
selection, and to ask whether single moved genes preferentially map to a
neighbourhood matching their ancestral one.

## Contents
- [Data](#data)
- [Repository layout](#repository-layout)
- [Dependencies](#dependencies)

## Data

| Dataset | N | Source |
|---|---|---|
| Reference genome | 1 | ([TAIR10](https://www.arabidopsis.org/download/list?dir=Genes%2FTAIR10_genome_release))|
| *A. thaliana* genomes | 27 | ([assemblies](https://www.ebi.ac.uk/ena/browser/view/PRJEB73474)) |
| *A. lyrata* genomes | 31 | ([assemblies](https://www.ebi.ac.uk/ena/browser/view/PRJEB73474))  |
| Recombination rates  | 2 | ([Supplementary Data 2–3](https://www.nature.com/articles/s41467-022-31509-8#data-availability))|
| Mutation rates  | 2 | ([File S1, Mutation list](https://doi.org/10.25386/genetics.6456065.))|
| Capsella genomes  | 3 | ([source](https://capsella.uk/download/))|

## Repository layout

Steps are numbered in execution order; each directory has its own README.md with
inputs, outputs and usage.

1. [Whole-genome alignment](/scripts/01_wg_alignment/) using pannagram
2. [Convert pannagram alignment to VCF](scripts/02_alignment_to_vcf) to get variable and non-variable sites
3. [Identify 4-fold degenerate sites](scripts/03_get_degenerate_sites)
4. [Identify 1:1 orthologs](scripts/04_get_orthologous_thal_lyr) between *A. thaliana* and *A. lyrata*
5. [Nucleotide diversity (π) and divergence (d<sub>XY</sub>)](scripts/05_diversity_divergence)
6. [Mutation rate estimation](scripts/06_mutation_rate)
7. [Recombination rate analysis (cM/Mb)](scripts/07_recombination_rate)
8. [dN/dS estimates](scripts/08_dnds) for *A. thaliana*
9. [Background selection](scripts/09_background_selection)
10. [Expression and enrichment analysis](scripts/10_expression_and_enrichment)
11. [Analysis of single moved genes](scripts/11_single_moved_genes)

## Figures 

## Authors and contributions 

## Dependencies

Software and exact versions used are listed in [`/versions/versions.md`](versions/versions.md).

