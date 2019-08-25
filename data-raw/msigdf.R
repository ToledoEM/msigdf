# GMT files were downloaded from Broad Institute GSAE website (http://software.broadinstitute.org/gsea/downloads.jsp)
# Due to the website need user registration to access the datasets. Local copies are in the repository subfolder ~/data-row/gmt/
# I couldn'd find a way to use curl or wget to save the files.
#
#
# Collections details (http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp)
#
# License Terms for MSigDB Gene Sets
# MSigDB release (v7.0 and above)
# MSigDB v7.0 and above are available under a Creative Commons style license, plus additional terms for some gene sets. (http://software.broadinstitute.org/gsea/msigdb_license_terms.jsp)



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


## For gene symbols

# Load gmt genesets files as lists
gmts <- dir(path = "data-raw/gmt/",pattern = "*.symbols.gmt")
for (i in seq_along(gmts)){ assign(gmts[i],gmtPathways(paste0("data-raw/gmt/",gmts[i]))) }

gmts <- ls(pattern = "v7")
msigdf<- list()
for (i in seq_along(gmts)){
  msigdf[[gmts[i]]] <- eval(parse(text = gmts[i])) %>% plyr::ldply(function(x) tibble(symbol=x), .id="geneset") %>%
    filter(symbol!="-") %>%
    mutate(symbol=as.character(symbol), geneset=as.character(geneset)) %>%
    tbl_df()
}

# Tidy up list to tbl_df


# Collapse multiple lists into a dataframe, with explicit splicing (!!!) to maintain list names
msigdf_symbol <- bind_rows(!!!msigdf,.id = "gs_labels")

# Add data groups into new columns gs_labels.
# gs_label colums are split for geneset (category_code) and subcategory_code, twice just becouse.
# Columns with raw data are drop.
# There are repeated genesets in C2.CP versus C2.*
msigdf_symbol <- msigdf_symbol %>% separate(gs_labels, c("label", "temp"), sep = "\\.v6", remove=FALSE) %>% dplyr::select(-temp) %>%
  separate(label,c("category_code","category_subcode"),sep = "[.]",extra = "drop") %>% dplyr::select(-gs_labels) %>% distinct()

# fix labeling for hallmark geneset
msigdf_symbol$category_code <- ifelse(msigdf_symbol$category_code=="h","hallmark",paste(msigdf_symbol$category_code))

# Based in human genes
msigdf.human <- msigdf_symbol

# Human to mouse symbols
# Not all human genes in MSigDB have a proper mouse homologous.
# Would recommend to check with the human geneset to be certain that the mouse geneset is still a good representation of a biological phenomena.
# Althoug a it is a remote posibility, I didn't compare the size of the geneset between human and mouse
library(biomaRt)
human <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")

# Create Look-up table of human mouse homologous
genes_lookuptbl <- getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = unique(msigdf_symbol$symbol) , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T) %>%
  dplyr::rename(symbol=HGNC.symbol,mouse.symbol=MGI.symbol)

# Create mouse output, clean output of genes without homology
msigdf.mouse <- msigdf_symbol %>% right_join(genes_lookuptbl,by="symbol") %>% dplyr::select(-symbol) %>% distinct() %>% filter(!is.na(category_code))

rm(genes_lookuptbl,human,mouse)

# Create data frame of urls to join to
msigdf.urls <- msigdf_symbol %>%
  distinct(category_code,category_subcode, geneset) %>%
  mutate(url=paste0("http://software.broadinstitute.org/gsea/msigdb/cards/", geneset))


# Save data in the package, and remove the original list objects
library(devtools)
use_data(msigdf.mouse, msigdf.human,msigdf.urls, overwrite=TRUE, compress='xz')
use_package("tibble")
detach("package:biomaRt", unload=TRUE)
rm(list=ls(pattern="v7.0"),msigdf,gmts,gmtPathways)
