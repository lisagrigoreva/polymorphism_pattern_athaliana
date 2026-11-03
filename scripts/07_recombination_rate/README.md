### 7. Recombination rate analysis (cM/Mb)

To build a recombination map and calculate recombination rates (cM/Mb), we used the male and female crossover data (Supplementary Data 1) from [Lian et al., 2022](https://doi.org/10.1038/s41467-022-31509-8).

**Script:** `scripts/recombination_rates_analysis.Rmd`

- **Input:**
  - male crossovers: `4314_ABCDEF.final.snp.ABEF.phase_v9.2.7.refinedCOs.hap.male.COs_freq_rand_chr.fl3.w1000s50.txt`
  - female crossovers: `4314_ABCDEF.final.snp.ABEF.phase_v9.2.7.refinedCOs.hap.female.COs_freq_rand_chr.fl3.w1000s50.txt`
- **Output:** recombination rate in non-overlapping windows (cM/Mb, mean of male and female)

