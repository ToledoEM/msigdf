# MSigDF: Molecular Signature Database (MSigDB) in a Data Frame

Abstract

This data package contains the Molecular Signature Database (MSigDB) for
both human and mouse in separate data frames (tibbles). Each data frame
(`msigdf.human` and `msigdf.mouse`) contains four columns: the
collection code (`h` or `c1`-`c9` for human, `mh` or `m1`-`m8` for
mouse), the sub-collection code, the gene set name, and the gene symbols
in that set. The `msigdf.urls` and `msigdf.mouse.urls` tibbles contain
links to descriptions of each gene set on the MSigDB website. **[Source
code available on GitHub](https://github.com/ToledoEM/msigdf)**.

## Data sources

Original data from the Broad Institute’s Molecular Signature Database
(MSigDB)[^1], redistributed as separate gmt data files from the MSigDB.

------------------------------------------------------------------------

***Procedure:***

*1. The current MSigDB v2026.1 gmt files were downloaded from Broad
ftp.*  
*2. This was done with the human and mouse gene sets*  
*3. Each collection was converted to a list in R, and written to a RData
file using [`save()`](https://rdrr.io/r/base/save.html).*

------------------------------------------------------------------------

See the script in `data-raw/` to see how the data frames (tibbles) were
created.

## Example usage

There are four data frames (tibbles) in this package. The `msigdf.human`
data frame has columns for each MSigDB collection divided by
sub-collection (like cc, bp and mf for C5). The format of the data is
tidy, so each row is a single gene set collection, sub-collection and
gene symbol. The `msigdf.mouse` data frame has the same structure for
the mouse collections. The `msigdf.urls` and `msigdf.mouse.urls` data
frames link the name of each gene set to its page on the MSigDB website.

New C5 ontology information was added to the category subcode for easy
filtering and consistency.

- HPO: Human Phenotype Ontology
- MF: GO Molecular Function ontology
- BP: GO Biological Process ontology
- CC: GO Cellular Component ontology

The data sets in this package have several million rows. The package
imports the tibble package so they’re displayed nicely.

``` r

library(dplyr)
library(tibble)
library(purrr)
library(msigdf)
```

Take a look:

``` r

msigdf.human %>% head()
```

    ## # A tibble: 6 × 4
    ##   category_code category_subcode geneset symbol 
    ##   <chr>         <chr>            <chr>   <chr>  
    ## 1 c1            all              MT      MT-ATP6
    ## 2 c1            all              MT      MT-ATP8
    ## 3 c1            all              MT      MT-CO1 
    ## 4 c1            all              MT      MT-CO2 
    ## 5 c1            all              MT      MT-CO3 
    ## 6 c1            all              MT      MT-CYB

``` r

msigdf.mouse %>% head()
```

    ## # A tibble: 6 × 4
    ##   category_code category_subcode geneset symbol 
    ##   <chr>         <chr>            <chr>   <chr>  
    ## 1 m1            all              MT      mt-Atp6
    ## 2 m1            all              MT      mt-Atp8
    ## 3 m1            all              MT      mt-Co1 
    ## 4 m1            all              MT      mt-Co2 
    ## 5 m1            all              MT      mt-Co3 
    ## 6 m1            all              MT      mt-Cytb

``` r

msigdf.urls %>% as.data.frame() %>% head()
```

    ##   category_code category_subcode  geneset
    ## 1            c1              all       MT
    ## 2            c1              all chr10p11
    ## 3            c1              all chr10p12
    ## 4            c1              all chr10p13
    ## 5            c1              all chr10p14
    ## 6            c1              all chr10p15
    ##                                                             url
    ## 1       http://software.broadinstitute.org/gsea/msigdb/cards/MT
    ## 2 http://software.broadinstitute.org/gsea/msigdb/cards/chr10p11
    ## 3 http://software.broadinstitute.org/gsea/msigdb/cards/chr10p12
    ## 4 http://software.broadinstitute.org/gsea/msigdb/cards/chr10p13
    ## 5 http://software.broadinstitute.org/gsea/msigdb/cards/chr10p14
    ## 6 http://software.broadinstitute.org/gsea/msigdb/cards/chr10p15

Just get the entries for the [KEGG non-homologous end joining
pathway](http://www.genome.jp/kegg/pathway/hsa/hsa03450.md):

``` r

msigdf.human %>% 
  filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")
```

    ## # A tibble: 26 × 4
    ##    category_code category_subcode geneset                         symbol 
    ##    <chr>         <chr>            <chr>                           <chr>  
    ##  1 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING DCLRE1C
    ##  2 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING DNTT   
    ##  3 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING FEN1   
    ##  4 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING LIG4   
    ##  5 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING MRE11  
    ##  6 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING NHEJ1  
    ##  7 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING POLL   
    ##  8 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING POLM   
    ##  9 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING PRKDC  
    ## 10 c2            cp.kegg_legacy   KEGG_NON_HOMOLOGOUS_END_JOINING RAD50  
    ## # ℹ 16 more rows

Some software, e.g., [fGSEA](https://github.com/ctlab/fgsea) might
require gene sets to be a named list of genes identifiers, where the
name of each element in the list is the name of the pathway. This is how
the data was originally structured, and we can return to it with
[`plyr::dlply()`](https://rdrr.io/pkg/plyr/man/dlply.html). Here, let’s
use only the hallmark sets, and after we `dlply` the data into this
named list format, get just the first few pathways, and in each of
those, just display the first few gene symbols.

``` r

msigdf.human %>%
  filter(category_code=="h") %>%
  select(geneset, symbol) %>%
  group_by(geneset) %>%
  summarize(symbol=list(symbol)) %>%
  deframe() %>%
  head() %>%
  map(head)
```

    ## $HALLMARK_ADIPOGENESIS
    ## [1] "ABCA1" "ABCB8" "ACAA2" "ACADL" "ACADM" "ACADS"
    ## 
    ## $HALLMARK_ALLOGRAFT_REJECTION
    ## [1] "AARS1"  "ABCE1"  "ABI1"   "ACHE"   "ACVR2A" "AKT1"  
    ## 
    ## $HALLMARK_ANDROGEN_RESPONSE
    ## [1] "ABCC4"   "ABHD2"   "ACSL3"   "ACTN1"   "ADAMTS1" "ADRM1"  
    ## 
    ## $HALLMARK_ANGIOGENESIS
    ## [1] "APOH"   "APP"    "CCND2"  "COL3A1" "COL5A2" "CXCL6" 
    ## 
    ## $HALLMARK_APICAL_JUNCTION
    ## [1] "ACTA1" "ACTB"  "ACTC1" "ACTG1" "ACTG2" "ACTN1"
    ## 
    ## $HALLMARK_APICAL_SURFACE
    ## [1] "ADAM10"   "ADIPOR2"  "AFAP1L2"  "AKAP7"    "APP"      "ATP6V0A4"

## Further exploration

The number of gene sets in each collection for each organism is
dependent of the construction at MSigDB.

**Human Collection of gene sets**
<https://www.gsea-msigdb.org/gsea/msigdb/human/collections.jsp>

``` r

msigdf.human %>%
  group_by(category_code,category_subcode) %>% 
  tally()
```

    ## # A tibble: 29 × 3
    ## # Groups:   category_code [10]
    ##    category_code category_subcode      n
    ##    <chr>         <chr>             <int>
    ##  1 c1            all               43707
    ##  2 c2            cgp              408654
    ##  3 c2            cp               179627
    ##  4 c2            cp.biocarta        4814
    ##  5 c2            cp.kegg_legacy    12801
    ##  6 c2            cp.kegg_medicus    9662
    ##  7 c2            cp.pid             8054
    ##  8 c2            cp.reactome      102437
    ##  9 c2            cp.wikipathways   41280
    ## 10 c3            mir              406232
    ## # ℹ 19 more rows

**Mouse Collection of gene sets**
<https://www.gsea-msigdb.org/gsea/msigdb/mouse/collections.jsp>

``` r

msigdf.mouse %>%
  group_by(category_code,category_subcode) %>% 
  tally()
```

    ## # A tibble: 16 × 3
    ## # Groups:   category_code [7]
    ##    category_code category_subcode      n
    ##    <chr>         <chr>             <int>
    ##  1 m1            all               41400
    ##  2 m2            cgp              116378
    ##  3 m2            cp                89841
    ##  4 m2            cp.biocarta        3959
    ##  5 m2            cp.reactome       75097
    ##  6 m2            cp.wikipathways   10785
    ##  7 m3            gtrd             163326
    ##  8 m3            mirdb            233370
    ##  9 m5            go               878221
    ## 10 m5            go.bp            651755
    ## 11 m5            go.cc            112349
    ## 12 m5            go.mf            114117
    ## 13 m5            mpt                2606
    ## 14 m7            all               70547
    ## 15 m8            all               47976
    ## 16 mh            all                7191

Get the URL for the hallmark set with the fewest number of genes (Notch
signaling). Optionally, `%>%` this to `browseURL` to open it up in your
browser.

``` r

msigdf.human %>%
  filter(category_code=="h") %>%
  count(geneset) %>%
  arrange(n) %>%
  head(1) %>%
  inner_join(msigdf.urls, by="geneset") %>%
  pull(url)
```

    ## [1] "http://software.broadinstitute.org/gsea/msigdb/cards/HALLMARK_NOTCH_SIGNALING"

Just look at the number of genes in each KEGG pathway (sorted descending
by the number of genes in that pathway):

``` r

msigdf.human %>%
  filter(category_code=="c2" & grepl("^KEGG_", geneset)) %>%
  count(geneset) %>% 
  arrange(desc(n))
```

    ## # A tibble: 844 × 2
    ##    geneset                                          n
    ##    <chr>                                        <int>
    ##  1 KEGG_OLFACTORY_TRANSDUCTION                    778
    ##  2 KEGG_PATHWAYS_IN_CANCER                        650
    ##  3 KEGG_NEUROACTIVE_LIGAND_RECEPTOR_INTERACTION   544
    ##  4 KEGG_MAPK_SIGNALING_PATHWAY                    534
    ##  5 KEGG_CYTOKINE_CYTOKINE_RECEPTOR_INTERACTION    528
    ##  6 KEGG_REGULATION_OF_ACTIN_CYTOSKELETON          426
    ##  7 KEGG_FOCAL_ADHESION                            398
    ##  8 KEGG_CHEMOKINE_SIGNALING_PATHWAY               376
    ##  9 KEGG_HUNTINGTONS_DISEASE                       366
    ## 10 KEGG_ENDOCYTOSIS                               362
    ## # ℹ 834 more rows

## Session info

    ## R version 4.6.1 (2026-06-24)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    ##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    ##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    ## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## time zone: UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] msigdf_2026.1 purrr_1.2.2   tibble_3.3.1  dplyr_1.2.1   knitr_1.51   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] vctrs_0.7.3       cli_3.6.6         rlang_1.3.0       xfun_0.60        
    ##  [5] otel_0.2.0        generics_0.1.4    textshaping_1.0.5 jsonlite_2.0.0   
    ##  [9] glue_1.8.1        htmltools_0.5.9   ragg_1.5.2        sass_0.4.10      
    ## [13] rmarkdown_2.31    evaluate_1.0.5    jquerylib_0.1.4   fastmap_1.2.0    
    ## [17] yaml_2.3.12       lifecycle_1.0.5   compiler_4.6.1    fs_2.1.0         
    ## [21] pkgconfig_2.0.3   systemfonts_1.3.2 digest_0.6.39     R6_2.6.1         
    ## [25] utf8_1.2.6        tidyselect_1.2.1  pillar_1.11.1     magrittr_2.0.5   
    ## [29] bslib_0.12.0      withr_3.0.3       tools_4.6.1       pkgdown_2.2.1    
    ## [33] cachem_1.1.0      desc_1.4.3

[^1]: <http://www.broad.mit.edu/gsea/msigdb/index.jsp>
