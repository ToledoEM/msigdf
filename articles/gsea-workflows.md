# Using msigdf with enrichment tools

Abstract

Recipes for reshaping the `msigdf` tibbles into the formats expected by
common gene set enrichment tools: `fgsea`, `clusterProfiler`, and
anything else that wants either a named list of gene sets or a
two-column `TERM2GENE` frame.

``` r

library(dplyr)
library(msigdf)
```

## Scope

`msigdf` ships the gene sets only. It deliberately does not depend on
any enrichment package, so `fgsea` and `clusterProfiler` are **not**
installed alongside it.

The chunks that reshape `msigdf` data are evaluated below, so the output
you see is real. The chunks that call an enrichment package are marked
`eval=FALSE` and are shown as recipes to copy — install the relevant
Bioconductor package first:

``` r

# install.packages("BiocManager")
BiocManager::install(c("fgsea", "clusterProfiler"))
```

## A named list of gene sets

`fgsea::fgsea()` and several other tools expect gene sets as a named
list: one element per gene set, each holding a character vector of gene
identifiers. [`split()`](https://rdrr.io/r/base/split.html) produces
exactly that.

Using the human hallmark collection (`category_code == "h"`):

``` r

hallmark <- msigdf.human %>%
  filter(category_code == "h")

pathways <- split(hallmark$symbol, hallmark$geneset)

length(pathways)
```

    ## [1] 50

``` r

lengths(pathways) %>% head()
```

    ##        HALLMARK_ADIPOGENESIS HALLMARK_ALLOGRAFT_REJECTION 
    ##                          200                          200 
    ##   HALLMARK_ANDROGEN_RESPONSE        HALLMARK_ANGIOGENESIS 
    ##                          101                           36 
    ##     HALLMARK_APICAL_JUNCTION      HALLMARK_APICAL_SURFACE 
    ##                          200                           44

``` r

pathways[["HALLMARK_NOTCH_SIGNALING"]] %>% head(10)
```

    ##  [1] "APH1A"  "ARRB1"  "CCND1"  "CUL1"   "DLL1"   "DTX1"   "DTX2"   "DTX4"  
    ##  [9] "FBXW11" "FZD1"

Feed that straight to `fgsea`, together with your own named vector of
ranking statistics:

``` r

library(fgsea)

# `stats` is a named numeric vector: names are gene symbols, values are the
# ranking metric (log fold change, signed -log10 p-value, ...).
res <- fgsea(pathways = pathways, stats = stats)

res %>%
  as_tibble() %>%
  arrange(padj) %>%
  select(pathway, pval, padj, NES, size)
```

Any collection works the same way. To restrict to one sub-collection,
filter on `category_subcode` as well:

``` r

reactome <- msigdf.human %>%
  filter(category_code == "c2", category_subcode == "cp.reactome")

reactome_pathways <- split(reactome$symbol, reactome$geneset)
length(reactome_pathways)
```

    ## [1] 1839

## A TERM2GENE data frame

`clusterProfiler::enricher()` and `GSEA()` take a two-column data frame:
gene set name first, gene identifier second. That is the `msigdf` layout
minus the collection columns.

``` r

term2gene <- msigdf.human %>%
  filter(category_code == "h") %>%
  select(term = geneset, gene = symbol)

term2gene
```

    ## # A tibble: 7,322 × 2
    ##    term                  gene 
    ##    <chr>                 <chr>
    ##  1 HALLMARK_ADIPOGENESIS ABCA1
    ##  2 HALLMARK_ADIPOGENESIS ABCB8
    ##  3 HALLMARK_ADIPOGENESIS ACAA2
    ##  4 HALLMARK_ADIPOGENESIS ACADL
    ##  5 HALLMARK_ADIPOGENESIS ACADM
    ##  6 HALLMARK_ADIPOGENESIS ACADS
    ##  7 HALLMARK_ADIPOGENESIS ACLY 
    ##  8 HALLMARK_ADIPOGENESIS ACO2 
    ##  9 HALLMARK_ADIPOGENESIS ACOX1
    ## 10 HALLMARK_ADIPOGENESIS ADCY6
    ## # ℹ 7,312 more rows

Then:

``` r

library(clusterProfiler)

# Over-representation on a character vector of gene symbols.
ora <- enricher(gene = my_genes, TERM2GENE = term2gene)

# Or GSEA on a sorted, named numeric vector.
gsea <- GSEA(geneList = sorted_stats, TERM2GENE = term2gene)
```

## Mouse

The mouse tibble has the same shape. Note the collection codes differ:
hallmark is `mh` rather than `h`, and the numbered collections run
`m1`-`m8`.

``` r

msigdf.mouse %>%
  distinct(category_code) %>%
  arrange(category_code)
```

    ## # A tibble: 7 × 1
    ##   category_code
    ##   <chr>        
    ## 1 m1           
    ## 2 m2           
    ## 3 m3           
    ## 4 m5           
    ## 5 m7           
    ## 6 m8           
    ## 7 mh

``` r

mouse_hallmark <- msigdf.mouse %>%
  filter(category_code == "mh")

mouse_pathways <- split(mouse_hallmark$symbol, mouse_hallmark$geneset)

length(mouse_pathways)
```

    ## [1] 50

``` r

mouse_pathways[["HALLMARK_NOTCH_SIGNALING"]] %>% head(10)
```

    ##  [1] "Aph1a"  "Arrb1"  "Ccnd1"  "Cul1"   "Dll1"   "Dtx1"   "Dtx2"   "Dtx4"  
    ##  [9] "Fbxw11" "Fzd1"

Mouse gene sets carry mouse symbols, so no ortholog mapping is needed if
your data is already mouse.

## Linking results back to MSigDB

`msigdf.urls` and `msigdf.mouse.urls` map every gene set name to its
page on the MSigDB website. Join enrichment output against them to get
clickable links in a report.

``` r

top_sets <- msigdf.human %>%
  filter(category_code == "h") %>%
  count(geneset, name = "n_genes") %>%
  arrange(n_genes) %>%
  head(5)

top_sets %>%
  inner_join(msigdf.urls, by = "geneset") %>%
  select(geneset, n_genes, url)
```

    ## # A tibble: 5 × 3
    ##   geneset                             n_genes url                               
    ##   <chr>                                 <int> <chr>                             
    ## 1 HALLMARK_NOTCH_SIGNALING                 32 http://software.broadinstitute.or…
    ## 2 HALLMARK_ANGIOGENESIS                    36 http://software.broadinstitute.or…
    ## 3 HALLMARK_HEDGEHOG_SIGNALING              36 http://software.broadinstitute.or…
    ## 4 HALLMARK_PANCREAS_BETA_CELLS             40 http://software.broadinstitute.or…
    ## 5 HALLMARK_WNT_BETA_CATENIN_SIGNALING      42 http://software.broadinstitute.or…

The same join applied to an `fgsea` result:

``` r

res %>%
  as_tibble() %>%
  arrange(padj) %>%
  head(20) %>%
  inner_join(msigdf.urls, by = c("pathway" = "geneset")) %>%
  select(pathway, padj, NES, url)
```

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
    ## [1] msigdf_2026.1 dplyr_1.2.1   knitr_1.51   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] vctrs_0.7.3       cli_3.6.6         rlang_1.3.0       xfun_0.60        
    ##  [5] otel_0.2.0        generics_0.1.4    textshaping_1.0.5 jsonlite_2.0.0   
    ##  [9] glue_1.8.1        htmltools_0.5.9   ragg_1.5.2        sass_0.4.10      
    ## [13] rmarkdown_2.31    evaluate_1.0.5    jquerylib_0.1.4   tibble_3.3.1     
    ## [17] fastmap_1.2.0     yaml_2.3.12       lifecycle_1.0.5   compiler_4.6.1   
    ## [21] fs_2.1.0          pkgconfig_2.0.3   systemfonts_1.3.2 digest_0.6.39    
    ## [25] R6_2.6.1          utf8_1.2.6        tidyselect_1.2.1  pillar_1.11.1    
    ## [29] magrittr_2.0.5    bslib_0.12.0      withr_3.0.3       tools_4.6.1      
    ## [33] pkgdown_2.2.1     cachem_1.1.0      desc_1.4.3
