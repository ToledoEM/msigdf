# GMT files were downloaded from Broad Institute GSAE website (http://software.broadinstitute.org/gsea/downloads.jsp)
# Due to the website need user registration to access the datasets. Local copies are in the repository subfolder ~/data-row/gmt/
# I couldn'd find a way to use curl or wget to save the files.
#
# Files Downloaded
# c1.all.v6.1.symbols.gmt
# c2.cgp.v6.1.symbols.gmt
# c2.cp.biocarta.v6.1.symbols.gmt
# c2.cp.kegg.v6.1.symbols.gmt
# c2.cp.reactome.v6.1.symbols.gmt
# c3.mir.v6.1.symbols.gmt
# c3.tft.v6.1.symbols.gmt
# c4.cgn.v6.1.symbols.gmt
# c4.cm.v6.1.symbols.gmt
# c5.bp.v6.1.symbols.gmt
# c5.cc.v6.1.symbols.gmt
# c5.mf.v6.1.symbols.gmt
# c6.all.v6.1.symbols.gmt
# c7.all.v6.1.symbols.gmt
# h.all.v6.1.symbols.gmt
#
#
# Collections details (http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp)
#
# License Terms for MSigDB Gene Sets
# MSigDB release (v6.0 and above)
# MSigDB v6.0 and above are available under a Creative Commons style license, plus additional terms for some gene sets. (http://software.broadinstitute.org/gsea/msigdb_license_terms.jsp)



library(tidyverse)

#Function to read GTM files, output list. From fgsea package (https://github.com/ctlab/fgsea)
gmtPathways <- function(gmt.file) {
  pathwayLines <- strsplit(readLines(gmt.file), "\t")
  pathways <- lapply(pathwayLines, utils::tail, -2)
  names(pathways) <- sapply(pathwayLines, head, 1)
  pathways
}


# Load gmt genesets files as lists
gmts <- dir(path = "data-raw/gmt/",pattern = "*.gmt")
for (i in seq_along(gmts)){ assign(gmts[i],gmtPathways(paste0("data-raw/gmt/",gmts[i]))) }

gmts <- ls(pattern = "v6")
msigdf<- list()
for (i in seq_along(gmts)){
  msigdf[[gmts[i]]] <- eval(parse(text = gmts[i])) %>% plyr::ldply(function(x) data_frame(symbol=x), .id="geneset") %>%
    filter(symbol!="-") %>%
    mutate(symbol=as.character(symbol), geneset=as.character(geneset)) %>%
    tbl_df()
}

# Tidy up list to tbl_df
# collapse multiple lists into a dataframe
# Add data groups into new columns gs_labels
# gs_label colums are split for geneset (category_code) and subcategory_code, twice just becouse.
# Columns with no relevant or raw data are drop
# There are repeated genesets in C2.CP versus C2.*

msigdf <- bind_rows(!!!msigdf,.id = "gs_labels")
msigdf <- msigdf %>% separate(gs_labels, c("label", "temp"), sep = "\\.v6", remove=FALSE) %>% dplyr::select(-temp) %>%
  separate(label,c("category_code","category_subcode"),sep = "[.]",extra = "drop") %>% dplyr::select(-gs_labels) %>% distinct()


# fix labeling for hallmark geneset
msigdf$category_code <- ifelse(msigdf$category_code=="h","hallmark",paste(msigdf$category_code))


# Dased in human genes
msigdf.human <- msigdf


# Human to mouse symbols
# Not all human genes in MSigDB have a proper mouse homologous.
# Would recommend to check it before use.
library(biomaRt)
human <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")

# Create Look-up table of human mouse homologous
genes_lookuptbl <- getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = unique(msigdf$symbol) , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T) %>%
  dplyr::rename(symbol=HGNC.symbol,mouse.symbol=MGI.symbol)

# Create mouse output, clean output of genes without homology
msigdf.mouse <- msigdf %>% right_join(genes_lookuptbl,by="symbol") %>% dplyr::select(-symbol) %>% distinct() %>% filter(!is.na(category_code))

rm(genes_lookuptbl)

# Create data frame of urls to join to
msigdf.urls <- msigdf %>%
  distinct(collection, geneset) %>%
  mutate(url=paste0("http://software.broadinstitute.org/gsea/msigdb/cards/", geneset))


# Save data in the package, and remove the original list objects
devtools::use_data(msigdf.human, msigdf.mouse, msigdf.urls, overwrite=TRUE, compress='xz')
devtools::use_package("tibble")
detach("package:biomaRt", unload=TRUE)
rm(list=ls(pattern="v6.1"),human,mouse,msigdf,gmts,gmtPathways)
