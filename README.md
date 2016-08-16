# MSigDF

The [Molecular Signatures Database (MSigDB)](http://www.broad.mit.edu/gsea/msigdb/index.jsp) in a data frame. 

Current version: [v5.1](http://www.broadinstitute.org/cancer/software/gsea/wiki/index.php/MSigDB_v5.1_Release_Notes) (January 2016).

## Installation

```r
# Install devtools if you don't already have it
install.packages("devtools")

# Just get the data
devtools::install_github("stephenturner/msigdf")

# Get the data and build the vignette (requires plyr, dplyr, tidyr, knitr, rmarkdown)
devtools::install_github("stephenturner/msigdf", build_vignettes = TRUE)
```

## Example usage

See the [package vignette](https://rawgit.com/stephenturner/msigdf/master/inst/doc/msigdf.html) for more.

```r
library(dplyr)
library(msigdf)
vignette("msigdf")
```

```r
msigdf.human %>% 
  filter(collection=="hallmark") %>% 
  head
```

```
  collection                          geneset entrez
1   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB   3726
2   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB   2920
3   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB    467
4   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB   4792
5   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB   7128
6   hallmark HALLMARK_TNFA_SIGNALING_VIA_NFKB   5743
```

```r
msigdf.human %>% filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")
```

```
   collection                         geneset entrez
1          c2 KEGG_NON_HOMOLOGOUS_END_JOINING   7518
2          c2 KEGG_NON_HOMOLOGOUS_END_JOINING   4361
3          c2 KEGG_NON_HOMOLOGOUS_END_JOINING  27343
4          c2 KEGG_NON_HOMOLOGOUS_END_JOINING  27434
5          c2 KEGG_NON_HOMOLOGOUS_END_JOINING 731751
6          c2 KEGG_NON_HOMOLOGOUS_END_JOINING  79840
7          c2 KEGG_NON_HOMOLOGOUS_END_JOINING   3981
8          c2 KEGG_NON_HOMOLOGOUS_END_JOINING   2237
9          c2 KEGG_NON_HOMOLOGOUS_END_JOINING   1791
10         c2 KEGG_NON_HOMOLOGOUS_END_JOINING   7520
11         c2 KEGG_NON_HOMOLOGOUS_END_JOINING  10111
12         c2 KEGG_NON_HOMOLOGOUS_END_JOINING   2547
13         c2 KEGG_NON_HOMOLOGOUS_END_JOINING   5591
14         c2 KEGG_NON_HOMOLOGOUS_END_JOINING  64421
```

See the [package vignette](https://rawgit.com/stephenturner/msigdf/master/inst/doc/msigdf.html) for more.
