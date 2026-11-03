#!/usr/bin/env python3
"""
Convert HDF5 sequence and reference data to VCF format.
Takes file with positions and file with nucleotides and creates a pseudo-vcf file.
Usage: python h5_to_vcf.py --ref ref_1_1_TAIR10.h5 --seq seq_1_1_TAIR10.h5 --out output_chr1.vcf --chrom Chr1
"""

import h5py
import argparse
import sys

VALID_BASES = {"A", "C", "G", "T"}
MISSING_BASES = {"N", "-"}
# Reference position is always last in the file
def get_reference_positions(ref_h5_path): 
    with h5py.File(ref_h5_path, "r") as f:
        sample_names = sorted(f["accs"].keys())
        ref_name = sample_names[-1]  # last accession is reference
        ref_positions = f["accs"][ref_name][:]
    return ref_positions
# Get sequences
def get_sequences(seq_h5_path):
    with h5py.File(seq_h5_path, "r") as f:
        sample_names = sorted(f["accs"].keys())
        sequences = {name: f["accs"][name][:].astype(str) for name in sample_names}
    return sample_names, sequences

# Write pseudo-vcf file
def write_vcf(output_path, chrom, ref_positions, sample_names, sequences):
    with open(output_path, "w") as fout:
        # Write VCF header
        fout.write("##fileformat=VCFv4.2\n")
        fout.write(f"##reference=TAIR10\n")
        fout.write('##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">\n')
        fout.write("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t" + "\t".join(sample_names[:-1]) + "\n")
        num_positions = len(ref_positions)
        for i in range(num_positions):
            pos = ref_positions[i]
            ref_base = sequences[sample_names[-1]][i]
            if ref_base not in VALID_BASES:
                continue  # skip invalid reference bases
            sample_bases = [sequences[name][i] for name in sample_names[:-1]]
            alt_alleles = sorted(set(b for b in sample_bases if b in VALID_BASES and b != ref_base))
            alt_field = ",".join(alt_alleles) if alt_alleles else "."
            genotypes = []
            for base in sample_bases:
                if base in MISSING_BASES or base not in VALID_BASES:
                    genotypes.append("./.")
                elif base == ref_base:
                    genotypes.append("0/0")
                elif base in alt_alleles:
                    allele_index = alt_alleles.index(base) + 1
                    genotypes.append(f"{allele_index}/{allele_index}")
                else:
                    genotypes.append("./.")

            fout.write(f"{chrom}\t{pos}\t.\t{ref_base}\t{alt_field}\t.\tPASS\t.\tGT\t" + "\t".join(genotypes) + "\n")

def main():
    parser = argparse.ArgumentParser(description="Convert HDF5 sequence and reference data to VCF.")
    parser.add_argument("--ref", required=True, help="Path to reference HDF5 file (e.g. ref_1_1_TAIR10.h5)")
    parser.add_argument("--seq", required=True, help="Path to sequence HDF5 file (e.g. seq_1_1_TAIR10.h5)")
    parser.add_argument("--out", required=True, help="Output VCF file path")
    parser.add_argument("--chrom", required=True, help="Chromosome name (e.g. Chr1)")
    args = parser.parse_args()
    print(f"Loading reference positions from {args.ref}...")
    ref_positions = get_reference_positions(args.ref)

    print(f"Loading sequences from {args.seq}...")
    sample_names, sequences = get_sequences(args.seq)

    print(f"Writing VCF to {args.out}...")
    write_vcf(args.out, args.chrom, ref_positions, sample_names, sequences)

    print("Done!")

if __name__ == "__main__":
    main()
