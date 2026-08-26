# Build the msigdf data frames from the MSigDB GMT files.
#
# GMT files are downloaded from the Broad Institute GSEA ftp site by
# data-raw/get_gmt.sh into data-raw/human_gmt/ and data-raw/mouse_gmt/.
# Those folders are not tracked in the repository.
#
# Collections details:
#   https://www.gsea-msigdb.org/gsea/msigdb/collections.jsp
#
# Run from the repository root:
#   Rscript data-raw/msigdf.R
#
# This script only regenerates data/*.rda. Documentation and package checks
# are separate developer steps -- see the Building section of README.md.

library(plyr)
library(dplyr)
library(tidyr)
library(tibble)

# Version is read from data-raw/data_url.yml so a release bump only needs to be
# made in one place. Every version-dependent pattern below is derived from it.
read_version <- function(yml = "data-raw/data_url.yml") {
  lines <- readLines(yml, warn = FALSE)
  version_line <- lines[grep("^version:", lines)]
  if (length(version_line) == 0) {
    stop("No version found in ", yml)
  }
  trimws(sub("^version:\\s*", "", version_line[1]))
}

# Read a GMT file into a named list of gene sets.
# From the fgsea package (https://github.com/ctlab/fgsea).
gmtPathways <- function(gmt.file) {
  pathwayLines <- strsplit(readLines(gmt.file), "\t")
  pathways <- lapply(pathwayLines, utils::tail, -2)
  names(pathways) <- sapply(pathwayLines, head, 1)
  pathways
}

# Build the tidy gene set table and the matching URL table for one organism.
#
# gmt_dir    directory holding the *.symbols.gmt files for this organism
# version    MSigDB version, e.g. "2026.1"
# url_prefix base URL that each geneset name is appended to
#
# File names look like c2.cp.kegg_legacy.v2026.1.Hs.symbols.gmt. Stripping the
# version suffix leaves c2.cp.kegg_legacy, which splits into the category code
# (c2) and the category subcode (cp.kegg_legacy).
build_msigdf <- function(gmt_dir, version, url_prefix) {
  version_regex <- gsub(".", "\\.", version, fixed = TRUE)

  files <- list.files(gmt_dir, pattern = "\\.symbols\\.gmt$", full.names = TRUE)
  files <- files[grepl(paste0("\\.v", version_regex, "\\."), basename(files))]
  if (length(files) == 0) {
    stop("No v", version, " *.symbols.gmt files found in ", gmt_dir)
  }

  label_regex <- paste0("\\.v", version_regex, "\\...\\.symbols\\.gmt$")
  labels <- sub(label_regex, "", basename(files))

  pathways <- lapply(files, gmtPathways)
  names(pathways) <- labels

  tbl <- pathways %>%
    lapply(function(p) plyr::ldply(p, function(x) tibble(symbol = x), .id = "geneset")) %>%
    bind_rows(.id = "gs_labels") %>%
    filter(symbol != "-") %>%
    mutate(
      symbol = as.character(symbol),
      geneset = as.character(geneset)
    ) %>%
    separate(gs_labels, c("category_code", "category_subcode"),
             sep = "[.]", extra = "merge", fill = "right") %>%
    distinct() %>%
    as_tibble()

  urls <- tbl %>%
    distinct(category_code, category_subcode, geneset) %>%
    mutate(url = paste0(url_prefix, geneset))

  list(data = tbl, urls = urls)
}

version <- read_version()

human <- build_msigdf(
  "data-raw/human_gmt", version,
  "https://www.gsea-msigdb.org/gsea/msigdb/human/geneset/"
)
mouse <- build_msigdf(
  "data-raw/mouse_gmt", version,
  "https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/"
)

msigdf.human <- human$data
msigdf.urls <- human$urls
msigdf.mouse <- mouse$data
msigdf.mouse.urls <- mouse$urls

# Tally so a bad parse is visible when run non-interactively.
print(msigdf.human %>% group_by(category_code, category_subcode) %>% tally(), n = Inf)
print(msigdf.mouse %>% group_by(category_code, category_subcode) %>% tally(), n = Inf)

usethis::use_data(msigdf.human, msigdf.mouse, msigdf.urls, msigdf.mouse.urls,
                  overwrite = TRUE, compress = "xz")
