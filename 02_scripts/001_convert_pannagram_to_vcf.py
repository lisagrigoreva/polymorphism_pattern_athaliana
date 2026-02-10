#!/usr/bin/env python3
"""
Simple script to convert HDF5 sequence data to VCF format.
Usage: python script.py <input.h5> <output.vcf.gz> <chromosome>
Example: python script.py seq_5_5.h5 output.vcf.gz Chr5
"""

import h5py
import numpy as np
import gzip
import sys
import os

# ============================================================================
# STEP 1: Convert HDF5 to TSV (table format)
# ============================================================================
def h5_to_tsv(in_path, out_path):
    """Read HDF5 file and write to TSV table."""
    print(f"Step 1: Converting {in_path} to TSV...")

    # Open input HDF5 file and output gzipped TSV file
    with h5py.File(in_path, "r") as f, gzip.open(out_path, "wt") as out:
        # Get all sample names from the HDF5 file
        sample_names = sorted(f["accs"].keys())

        # Get the data for each sample
        datasets = [f["accs"][name] for name in sample_names]

        # Get the length (number of positions)
        num_positions = datasets[0].shape[0]

        # Write header line
        out.write("pos\t" + "\t".join(sample_names) + "\n")

        # Process in chunks to save memory (500,000 positions at a time)
        chunk_size = 500_000
        for start in range(0, num_positions, chunk_size):
            end = min(start + chunk_size, num_positions)

            # Read data for this chunk from all samples
            chunk_data = np.stack([ds[start:end] for ds in datasets], axis=1).astype(str)

            # Create position column (1-based numbering)
            positions = (np.arange(start, end) + 1).astype(str).reshape(-1, 1)

            # Combine positions with data
            output_chunk = np.concatenate([positions, chunk_data], axis=1)

            # Write to file
            out.write("\n".join("\t".join(row) for row in output_chunk) + "\n")

    print(f"   Done! Wrote: {out_path}")

# ============================================================================
# STEP 2: Convert TSV to VCF format
# ============================================================================
def tsv_to_vcf(in_tsv, out_vcf, chrom):
    """Convert TSV table to VCF format."""
    print(f"Step 2: Converting {in_tsv} to VCF...")

    # Valid DNA bases
    valid_bases = {"A", "C", "G", "T"}
    missing_bases = {"N", "-"}

    # Determine if output should be gzipped
    is_gzipped = out_vcf.endswith(".gz")
    opener_out = gzip.open if is_gzipped else open
    mode_out = "wt" if is_gzipped else "w"

    # Open input TSV and output VCF
    with gzip.open(in_tsv, "rt") as fin, opener_out(out_vcf, mode_out) as fout:
        # Read header line
        header = fin.readline().strip().split("\t")
        samples = header[1:-1]  # All columns except first (pos) and last (reference)
        ref_name = header[-1]   # Last column is the reference genome

        print(f"   Reference genome: {ref_name}")
        print(f"   Number of samples: {len(samples)}")

        # Write VCF header
        fout.write("##fileformat=VCFv4.2\n")
        fout.write(f"##reference={ref_name}\n")
        fout.write("##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n")
        fout.write("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t" + "\t".join(samples) + "\n")

        # Process each position
        for line in fin:
            parts = line.strip().split("\t")
            position = parts[0]
            bases = parts[1:]

            ref_base = bases[-1]        # Last column = reference base
            sample_bases = bases[:-1]   # All other columns = sample bases

            # Skip if reference is not A, C, G, or T
            if ref_base not in valid_bases:
                continue

            # Find alternate alleles (bases different from reference)
            alt_alleles = sorted(set(b for b in sample_bases
                                    if b in valid_bases and b != ref_base))

            # Format ALT field
            alt_field = ",".join(alt_alleles) if alt_alleles else "."

            # Create genotype calls for each sample
            genotypes = []
            for base in sample_bases:
                if base in missing_bases or base not in valid_bases:
                    genotypes.append("./.")  # Missing
                elif base == ref_base:
                    genotypes.append("0/0")  # Reference
                elif base in alt_alleles:
                    allele_index = alt_alleles.index(base) + 1
                    genotypes.append(f"{allele_index}/{allele_index}")  # Alternate
                else:
                    genotypes.append("./.")  # Unknown

            # Write VCF line
            vcf_line = f"{chrom}\t{position}\t.\t{ref_base}\t{alt_field}\t.\tPASS\t.\tGT\t"
            vcf_line += "\t".join(genotypes) + "\n"
            fout.write(vcf_line)

    print(f"   Done! Wrote: {out_vcf}")

# ============================================================================
# MAIN PROGRAM
# ============================================================================
if __name__ == "__main__":
    # Check command line arguments
    if len(sys.argv) != 4:
        print("ERROR: Wrong number of arguments!")
        print("Usage: python script.py <input.h5> <output.vcf.gz> <chromosome>")
        print("Example: python script.py seq_5_5.h5 output.vcf.gz Chr5")
        sys.exit(1)

    # Get arguments
    input_h5 = sys.argv[1]
    output_vcf = sys.argv[2]
    chromosome = sys.argv[3]

    # Create intermediate TSV filename (always different from output)
    # Remove extension and add _temp.tsv.gz
    base_name = os.path.splitext(output_vcf)[0]  # Remove .gz or .vcf
    if base_name.endswith(".vcf"):
        base_name = os.path.splitext(base_name)[0]  # Remove .vcf if .vcf.gz
    intermediate_tsv = base_name + "_temp.tsv.gz"

    print("=" * 60)
    print("HDF5 to VCF Converter")
    print("=" * 60)
    print(f"Input H5: {input_h5}")
    print(f"Output VCF: {output_vcf}")
    print(f"Temp TSV: {intermediate_tsv}")
    print("=" * 60)

    # Run conversion
    h5_to_tsv(input_h5, intermediate_tsv)
    tsv_to_vcf(intermediate_tsv, output_vcf, chromosome)

    print("=" * 60)
    print("COMPLETE!")
    print(f"Output VCF: {output_vcf}")
    print(f"Temp TSV: {intermediate_tsv}")
    print("=" * 60)
