library(tidyverse)

#Function GTM to list from fgsea package (https://github.com/ctlab/fgsea)
gmtPathways <- function(gmt.file) {
  pathwayLines <- strsplit(readLines(gmt.file), "\t")
  pathways <- lapply(pathwayLines, utils::tail, -2)
  names(pathways) <- sapply(pathwayLines, head, 1)
  pathways
}

# Load gmts as lists
gmts <- dir(path = "data-raw/gmt/",pattern = "*.gmt")
for (i in seq_along(gmts)){
  assign(gmts[i],gmtPathways(paste0("data-raw/gmt/",gmts[i])))
}


# All the gmts as lists
gmts <- ls(pattern = "v6")
msigdf<- list()
for (i in seq_along(gmts)){
  msigdf[[gmts[i]]] <- eval(parse(text = gmts[i])) %>% plyr::ldply(function(x) data_frame(symbol=x), .id="geneset") %>%
    filter(symbol!="-") %>%
    mutate(symbol=as.character(symbol), geneset=as.character(geneset)) %>%
    tbl_df()
}

# Tidy up list to tbl_df
msigdf <- bind_rows(!!!msigdf,.id = "groups")
msigdf <- msigdf %>% separate(groups, c("label", "temp"), sep = ".v6", remove=FALSE) %>% dplyr::select(-temp) %>%
  separate(label,c("category_code","category_subcode")) %>% dplyr::select(-groups)

#sanity test
msigdf %>% group_by(category_code,category_subcode) %>% dplyr::summarise(n=n())


#based in human genes
msigdf.human <- msigdf %>% distinct()

# fix labeling for hallmark geneset
msigdf.human$category_code <- ifelse(msigdf.human$category_code=="h","hallmark",paste(msigdf.human$category_code ))

# Human to mouse symbols
# Not all human genes in MSigDB have a proper mouse homologous.
# Would recommend to check it before use.
library(biomaRt)
human <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")

# Create Look-up table of human mouse homologous
genes_lookuptbl <- getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = unique(msigdf$symbol) , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T) %>%
  dplyr::rename(symbol=HGNC.symbol,mouse.symbol=MGI.symbol)

# Create mouse output, clean output
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
