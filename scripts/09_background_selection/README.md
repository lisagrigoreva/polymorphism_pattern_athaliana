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
