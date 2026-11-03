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
