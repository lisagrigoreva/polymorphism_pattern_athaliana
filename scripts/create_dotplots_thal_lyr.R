args <- commandArgs(trailingOnly = TRUE)
gene     <- args[1]
thal_dir <- args[2]
lyr_dir  <- args[3]
out_dir  <- args[4]

library(pannagram)

thal_path <- file.path(thal_dir, paste0(gene, ".fa"))
lyr_path  <- file.path(lyr_dir,  paste0(gene, ".fa"))

seq_thal <- readFasta(thal_path)
seq_lyr  <- readFasta(lyr_path)

out_file <- file.path(out_dir, paste0(gene, "_grid_thal_vs_lyr.png"))
png(out_file, width = 1200, height = 1000, res = 120)
dotgrid(seq_thal, seq_lyr, wsize = 15, nmatch = c(15, 12, 10, 8), nrow = 2)
dev.off()

cat("Saved:", out_file, "| exists:", file.exists(out_file), "\n")
