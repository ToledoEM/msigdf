# http://bioinf.wehi.edu.au/software/MSigDB/

library(plyr)
library(dplyr)
library(tidyr)

# human data
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_H_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c1_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c2_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c3_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c4_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c6_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c5_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/human_c7_v5p2.rdata"))

# mouse data
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_H_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c1_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c2_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c3_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c4_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c6_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c5_v5p2.rdata"))
load(url("http://bioinf.wehi.edu.au/software/MSigDB/mouse_c7_v5p2.rdata"))

# Each element of the msigdf list named "Org.Collection" is a data frame
# containing the name of the geneset and the entrez id of genes in that set.
msigdf <- list()
for (i in ls(pattern="^Hs\\.|^Mm\\.")) {
  message(i)
  msigdf[[i]] <- eval(parse(text=i)) %>%
    ldply(function(x) data_frame(entrez=x), .id="geneset") %>%
    filter(entrez!="-") %>%
    mutate(entrez=as.integer(entrez), geneset=as.character(geneset)) %>%
    tbl_df()
}; rm(i)
# Collapse that list into a large data.frame tbl, then recode the org column to
# spell out human/mouse, and sub "hallmark" for "H".
msigdf <- msigdf %>%
  bind_rows(.id="x") %>%
  separate(x, into=c("org", "collection")) %>%
  mutate(org=recode(org, Hs="human", Mm="mouse")) %>%
  mutate(collection=gsub("H", "hallmark", collection))
msigdf

# Create human-only and mouse-only subsets
msigdf.human <- msigdf %>% filter(org=="human") %>% select(-org)
msigdf.mouse <- msigdf %>% filter(org=="mouse") %>% select(-org)

# Create data frame of urls to join to
msigdf.urls <- msigdf %>%
  distinct(collection, geneset) %>%
  mutate(url=paste0("http://software.broadinstitute.org/gsea/msigdb/cards/", geneset))

# Save data in the package, and remove the original list objects
devtools::use_data(msigdf.human, msigdf.mouse, msigdf.urls, overwrite=TRUE, compress='xz')
devtools::use_package("tibble")
rm(list=ls(pattern="^Hs\\.|^Mm\\."))
rm(msigdf)
