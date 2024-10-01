# GMT files were downloaded from Broad Institute GSAE website (http://software.broadinstitute.org/gsea/downloads.jsp)
# Due to the website need user registration to access the datasets. Local copies are in the repository subfolder ~/data-row/gmt/
# I couldn'd find a way to use curl or wget to save the files.
#
#
# Collections details (http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp)
#



# library(tidyverse) #not recommended
library(plyr)
library(dplyr)
library(tidyr)
library(tibble)

#Function to read GTM files, output list. From fgsea package (https://github.com/ctlab/fgsea)
gmtPathways <- function(gmt.file) {
  pathwayLines <- strsplit(readLines(gmt.file), "\t")
  pathways <- lapply(pathwayLines, utils::tail, -2)
  names(pathways) <- sapply(pathwayLines, head, 1)
  pathways
}



# Human gene sets

## For gene symbols

# Load gmt genesets files as lists
gmts <- dir(path = "data-raw/gmt/human/msigdb_v2024.1.Hs_GMTs/",pattern = "*.symbols.gmt")
for (i in seq_along(gmts)){ assign(gmts[i],gmtPathways(paste0("data-raw/gmt/human/msigdb_v2024.1.Hs_GMTs/",gmts[i]))) }

# remove duplicated information
rm(c5.all.v2024.1.Hs.symbols.gmt,
   c5.go.v2024.1.Hs.symbols.gmt,
   c3.all.v2024.1.Hs.symbols.gmt,
   c4.all.v2024.1.Hs.symbols.gmt,
   c2.all.v2024.1.Hs.symbols.gmt,
   c2.cp.v2024.1.Hs.symbols.gmt,
   c7.all.v2024.1.Hs.symbols.gmt,
   msigdb.v2024.1.Hs.symbols.gmt)


gmts <- ls(pattern = "v2024")
msigdf<- list()
for (i in seq_along(gmts)){
  msigdf[[gmts[i]]] <- eval(parse(text = gmts[i])) %>% plyr::ldply(function(x) tibble(symbol=x), .id="geneset") %>%
    filter(symbol!="-") %>%
    mutate(symbol=as.character(symbol), geneset=as.character(geneset)) %>%
    as_tibble()
}

# Tidy up list to tbl_df


# Collapse multiple lists into a dataframe, with explicit splicing (!!!) to maintain list names
msigdf_symbol <- bind_rows(!!!msigdf,.id = "gs_labels")

# Add data groups into new columns gs_labels.
# gs_label colums are split for geneset (category_code) and subcategory_code, twice just becouse.
# Columns with raw data are drop.
# There are repeated genesets in C2.CP versus C2.*
# msigdf_symbol <- msigdf_symbol %>% separate(gs_labels, c("label", "temp"), sep = "\\.v7", remove=FALSE) %>% dplyr::select(-temp) %>%
#   separate(label,c("category_code","category_subcode"),sep = "[.]",extra = "drop") %>% dplyr::select(-gs_labels) %>% distinct()
#
# msigdf_symbol <- msigdf_symbol %>% mutate(gs_labels=gsub(gs_labels,pattern = "[.]v*gmt",replacement = "") ) %>%
#    separate(gs_labels,c("category_code","category_subcode"),sep = "[.]",extra = "drop") %>% distinct()


msigdf_symbol <- msigdf_symbol %>% mutate(gs_labels=gsub(gs_labels,pattern = "\\.v2024\\.1\\...\\.symbols|[.]v*gmt",replacement = "") ) %>%
  separate(gs_labels,c("category_code","category_subcode"),sep = "[.]",extra = "merge") %>%  distinct()


# tally
msigdf_symbol %>% group_by(category_code,category_subcode) %>% tally()


# Human genes
msigdf.human <- msigdf_symbol

# Create data frame of urls to join to
msigdf.urls <- msigdf_symbol %>%
  distinct(category_code,category_subcode, geneset) %>%
  mutate(url=paste0("http://software.broadinstitute.org/gsea/msigdb/cards/", geneset))


# Mouse

#clean
rm(list=ls(pattern="v2024."),msigdf,gmts)

# Load gmt genesets files as lists
gmts <- dir(path = "data-raw/gmt/mouse/msigdb_v2024.1.Mm_GMTs/",pattern = "*.symbols.gmt")
for (i in seq_along(gmts)){ assign(gmts[i],gmtPathways(paste0("data-raw/gmt/mouse/msigdb_v2024.1.Mm_GMTs/",gmts[i]))) }


# remove duplicated information
rm(m2.all.v2024.1.Mm.symbols.gmt,
   m2.cp.v2024.1.Mm.symbols.gmt,
   m5.all.v2024.1.Mm.symbols.gmt,
   m5.go.v2024.1.Mm.symbols.gmt,
   m3.all.v2024.1.Mm.symbols.gmt,
   msigdb.v2024.1.Mm.symbols.gmt)


gmts <- ls(pattern = "v2024")
msigdf<- list()
for (i in seq_along(gmts)){
  msigdf[[gmts[i]]] <- eval(parse(text = gmts[i])) %>% plyr::ldply(function(x) tibble(symbol=x), .id="geneset") %>%
    filter(symbol!="-") %>%
    mutate(symbol=as.character(symbol), geneset=as.character(geneset)) %>%
    as_tibble()
}



# Tidy up list to tbl_df
# Collapse multiple lists into a dataframe, with explicit splicing (!!!) to maintain list names
msigdf_symbol <- bind_rows(!!!msigdf,.id = "gs_labels")

# Add data groups into new columns gs_labels.
# gs_label colums are split for geneset (category_code) and subcategory_code, twice just becouse.
# Columns with raw data are drop.
# There are repeated genesets in C2.CP versus C2.*


msigdf_symbol <- msigdf_symbol %>%
  mutate(gs_labels=gsub(gs_labels,pattern = "\\.v2024\\.1\\...\\.symbols|[.]v*gmt",replacement = "") ) %>%
  separate(gs_labels,c("category_code","category_subcode"),sep = "[.]",extra = "merge") %>%
  distinct()

# tally
# msigdf_symbol %>% group_by(category_code,category_subcode) %>% tally()

# mouse genes
msigdf.mouse <- msigdf_symbol

# # Create data frame of urls to join to
msigdf.mouse.urls <- msigdf_symbol %>%
  distinct(category_code,category_subcode, geneset) %>%
  mutate(url=paste0("https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/", geneset))

# Save data in the package, and remove the original list objects
library(devtools)
use_data(msigdf.human,msigdf.mouse,msigdf.urls,msigdf.mouse.urls, overwrite=TRUE, compress='xz')
use_package("tibble")
# detach("package:biomaRt", unload=TRUE)
rm(list=ls(pattern="v2024."),msigdf,msigdf_symbol,i,gmts,gmtPathways)

library(roxygen2)
roxygenize(package.dir = ".", roclets = NULL, load_code = NULL, clean = T)
devtools::check()
