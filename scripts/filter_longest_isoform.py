#!/usr/bin/env python3
# filter_longest_isoform.py
# Usage: python filter_longest_isoform.py genome.gff proteins.faa output.faa

import sys
import gzip
from Bio import SeqIO

gff_file = sys.argv[1]
faa_file = sys.argv[2]
out_file = sys.argv[3]

def open_file(f):
    return gzip.open(f, "rt") if f.endswith(".gz") else open(f, "r")

def parse_attrs(attr_string):
    attrs = {}
    for item in attr_string.split(";"):
        if "=" in item:
            k, v = item.split("=", 1)
            attrs[k.strip()] = v.strip()
    return attrs

# Step 1: map protein_id -> locus_tag from CDS lines
print("Parsing GFF...")
protein_to_gene = {}

with open_file(gff_file) as f:
    for line in f:
        if line.startswith("#"):
            continue
        parts = line.strip().split("\t")
        if len(parts) < 9 or parts[2] != "CDS":
            continue
        attrs = parse_attrs(parts[8])
        protein_id = attrs.get("protein_id")
        locus_tag  = attrs.get("locus_tag")
        if protein_id and locus_tag:
            protein_to_gene[protein_id] = locus_tag

print(f"  Mapped {len(protein_to_gene)} protein_id -> locus_tag entries")

# Step 2: keep longest protein per locus_tag, rename header to locus_tag
print("Loading proteins...")
gene_to_best = {}  # locus_tag -> (seq, original_protein_id)

with open_file(faa_file) as f:
    for rec in SeqIO.parse(f, "fasta"):
        protein_id = rec.id
        gene_id = protein_to_gene.get(protein_id, protein_id)
        if gene_id not in gene_to_best or len(rec.seq) > len(gene_to_best[gene_id].seq):
            gene_to_best[gene_id] = rec

# Step 3: write output with locus_tag as sequence ID
print(f"Writing {len(gene_to_best)} longest isoforms...")
with open(out_file, "w") as out:
    for gene_id, rec in gene_to_best.items():
        # rename: locus_tag as primary ID, keep original protein_id in description
        out.write(f">{gene_id} protein_id={rec.id}\n")
        out.write(str(rec.seq) + "\n")

print("Done!")
