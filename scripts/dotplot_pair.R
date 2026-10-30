library(pannagram)

args  <- commandArgs(trailingOnly = TRUE)
gene  <- args[1]; dir_x <- args[2]; dir_y <- args[3]
out_dir <- args[4]; label <- args[5]

seq_x <- readFasta(file.path(dir_x, paste0(gene, ".fa")))
seq_y <- readFasta(file.path(dir_y, paste0(gene, ".fa")))

dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
out_file <- file.path(out_dir, paste0(gene, "_grid_", label, ".png"))

png(out_file, width = 1200, height = 1000, res = 120)
dotgrid(seq_x, seq_y, wsize = 15, nmatch = c(15, 12, 10, 8), nrow = 2)
dev.off()

cat("Saved:", out_file, "\n")
