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
