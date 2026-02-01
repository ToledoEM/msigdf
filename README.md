# MSigDF


<img src="https://toledoem.github.io/img/msigdf_logo.png" align="right" width=150/>



  
The [Molecular Signatures Database (MSigDB)](https://www.gsea-msigdb.org/gsea/msigdb/index.jsp) in a tidy data frame.    


This is the updated version of the archived repo of [@stephenturner](https://github.com/stephenturner/msigdf/pull/1)   
    
    
Current version: [v2026.1](https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_Latest/).

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16815639.svg)](https://doi.org/10.5281/zenodo.16815639)


**Important Notices**
- MSigDB v2026.1 (Jan 2026) is based on gene annotation data from Ensembl Release 115 (September 2026).
- Human realese notes: https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_2026.1.Hs/
- Mouse release notes: https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_2026.1.Mm/
    
    
## Installation

```r
# Install devtools if you don't already have it
install.packages("devtools")

# Just get the data
devtools::install_github("toledoem/msigdf")

# Get the data and build the vignette (requires tidyverse, knitr, rmarkdown)
devtools::install_github("toledoem/msigdf", build_vignettes = TRUE)
```

## Example usage


See the [package vignette](https://toledoem.github.io/msigdf/articles/msigdf.html) for more examples.   

```r
library(dplyr)
library(msigdf)
#vignette("msigdf")
```

```r
msigdf.human %>%
  filter(category_code=="h") %>%
  head
```

```
# A tibble: 6 x 4
  category_code category_subcode geneset                          symbol 
  <chr>         <chr>            <chr>                            <chr>  
1 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB JUNB   
2 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB CXCL2  
3 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB ATF3   
4 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB NFKBIA 
5 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB TNFAIP3
6 h      all              HALLMARK_TNFA_SIGNALING_VIA_NFKB PTGS2 
```

```r
> msigdf.human %>% 
    filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING") %>% 
      group_by(category_subcode) %>% 
        top_n(n = 10)
```

**Since now there are legacy and KEGG gene sets**

```
Selecting by symbol
# A tibble: 20 × 4
# Groups:   category_subcode [2]
   category_code category_subcode geneset                         symbol
   <chr>         <chr>            <chr>                           <chr> 
 1 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING LIG4  
 2 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING MRE11 
 3 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING NHEJ1 
 4 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING POLL  
 5 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING POLM  
 6 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING PRKDC 
 7 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING RAD50 
 8 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING XRCC4 
 9 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING XRCC5 
10 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING XRCC6 
11 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING LIG4  
12 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING MRE11 
13 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING NHEJ1 
14 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING POLL  
15 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING POLM  
16 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING PRKDC 
17 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING RAD50 
18 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC4 
19 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC5 
20 c2            cp               KEGG_NON_HOMOLOGOUS_END_JOINING XRCC6 
```


## Building

Code for building this data is in folder data-raw

See the [package vignette](https://toledoem.github.io/msigdf/articles/msigdf.html) for more.

## License
[MSigDF](https://creativecommons.org) by [US](https://creativecommons.org) is marked [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)   
    
![CC logo](https://mirrors.creativecommons.org/presskit/icons/cc.svg)    
![Zero logo](https://mirrors.creativecommons.org/presskit/icons/zero.svg)
