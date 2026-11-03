### 3. Identify 4-fold degenerate sites

In this study we measured diversity at 4-fold degenerate sites, which are treated as neutral. We identified these sites with [degenotate](https://github.com/harvardinformatics/degenotate), using the TAIR10 (*A. thaliana*) and MN47 (*A. lyrata*) annotations.

**Script:** `scripts/03_degeannotate.sh`

- **Input:** genome `.fasta` and annotation `.gtf` for each reference
- **Output:** `.bed` file with the degeneracy of each coding site
