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

## Steps:
1. Create a B map
Input: 1) neutral mask - 4 fold degenerate sites
2) Allele counts - allele frequency count calculated by script: ..py
3) Recombination map from Lian 

McVicker’s calc_bkgd program - formula 

Output:
1) Pre-computed B maps
B maps is background selection values for the certain length of the window
we obtain segment length (window) and background selection value (different fits of background selection)

2. Fitting the model

   Part1:
   Likelihood (what selection coefficient fits?)
   binomial log-likelihood per pair (probability that observed is as good as predicted using 9 selection coefficients)
   
Input: 1) neutral mask - 4 fold degenerate sites
2) Allele counts - allele frequency count calculated by script: ..py
4) B-map
5) Mutation rate value (flat and heterogenious mutation based on 0 degenerate sites)
Selection coefficient class is also reported. 
   
   Part1:
   Predicted diversity per segment (for plots and correlations)
Input: 1) neutral mask - 4 fold degenerate sites
2) Allele counts - allele frequency count calculated by script: ..py
4) B-map
5) Mutation rate value (flat and heterogenious mutation based on 0 degenerate sites)
6) Observed diversity in thaliana
Output: Predicted diversity per segment. We ourselves calculate variance explained by predicted diversity with background selection 







