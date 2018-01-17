# MSigDF

The [Molecular Signatures Database (MSigDB)](http://www.broad.mit.edu/gsea/msigdb/index.jsp) in a data frame.

Current version: [v6.1](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/MSigDB_v6.1_Release_Notes) (January 2018).

## Installation

```r
# Install devtools if you don't already have it
install.packages("devtools")

# Just get the data for MSigDB v5.2
devtools::install_github("stephenturner/msigdf") 

# Just get the data for MSigDB v6.1
devtools::install_github("toledoem/msigdf")


# Get the data and build the vignette (requires tidyverse, knitr, rmarkdown) for MSigDB v5.2
devtools::install_github("stephenturner/msigdf", build_vignettes = TRUE)


# Get the data and build the vignette (requires tidyverse, knitr, rmarkdown) for MSigDB v6.1
devtools::install_github("toledoem/msigdf", build_vignettes = TRUE)

```

## Example usage

See the [package vignette](http://stephenturner.github.io/msigdf/vignettes/msigdf.html) for more.

```r
library(dplyr)
library(msigdf)
vignette("msigdf")
```

```r
msigdf.human %>%
  filter(category_code=="hallmark") %>%
  head
```

```
# A tibble: 6 x 4
  category_code category_subcode geneset                          symbol
  <chr>         <chr>            <chr>                            <chr>
1 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB JUNB
2 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB CXCL2
3 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB ATF3
4 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB NFKBIA
5 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB TNFAIP3
6 hallmark      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB PTGS2
```

```r
msigdf.human %>% filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")
```

```
# A tibble: 14 x 4
   category_code category_subcode geneset                         symbol
   <chr>         <chr>            <chr>                           <chr>
 1 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC4
 2 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING MRE11A
 3 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING POLL
 4 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING POLM
 5 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING LOC731751
 6 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING NHEJ1
 7 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING LIG4
 8 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING FEN1
 9 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING DNTT
10 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC5
11 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING RAD50
12 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC6
13 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING PRKDC
```

See the [package vignette](http://stephenturner.github.io/msigdf/vignettes/msigdf.html) for more.
