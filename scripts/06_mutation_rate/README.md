### 6. Mutation rate estimation

We estimated mutation rates using data from mutation accumulation lines in *A. thaliana* ([Weng et al., 2019, *Genetics*](https://academic.oup.com/genetics/article/211/2/703/5931174)). We used two supplementary files from that paper:

- `Shared_mutations.csv`: mutations shared between multiple lines
- `Unique_mutations.csv`: mutations found in only one line

We followed the approach described in the Methods section of that paper and calculated mutation rates for each genomic context (genes, TEs) and for the 1:1 orthologous genes from step 4.

**Script:** `scripts/mutation_rate_analysis.Rmd` 

- **Input:** `Shared_mutations.csv`, `Unique_mutations.csv`, genome annotation, 1:1 ortholog coordinates (step 4)
- **Output:** mutation rates per genomic context and visualization of the mutation rates
