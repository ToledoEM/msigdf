# MSigDF

![](https://toledoem.github.io/img/msigdf_logo.png)

The [Molecular Signatures Database
(MSigDB)](https://www.gsea-msigdb.org/gsea/msigdb/index.jsp) in a tidy
data frame.

This is the updated version of the archived repo of
[@stephenturner](https://github.com/stephenturner/msigdf/pull/1)

Current version:
[v2026.1](https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_Latest/).

[![R-CMD-check](https://img.shields.io/github/actions/workflow/status/ToledoEM/msigdf/R-CMD-check.yaml?branch=master&label=R-CMD-check&style=flat-square)](https://github.com/ToledoEM/msigdf/actions/workflows/R-CMD-check.yaml)
[![lint](https://img.shields.io/github/actions/workflow/status/ToledoEM/msigdf/lint.yaml?branch=master&label=lint&style=flat-square)](https://github.com/ToledoEM/msigdf/actions/workflows/lint.yaml)
[![pkgdown](https://img.shields.io/github/actions/workflow/status/ToledoEM/msigdf/pkgdown.yaml?branch=master&label=pkgdown&style=flat-square)](https://toledoem.github.io/msigdf/)
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen?style=flat-square)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![license](https://img.shields.io/badge/license-CC0%201.0-lightgrey?style=flat-square)](https://creativecommons.org/publicdomain/zero/1.0/)
[![R](https://img.shields.io/badge/R-%3E%3D%203.5-blue?style=flat-square)](https://cran.r-project.org/)
[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.16815639-blue?style=flat-square)](https://doi.org/10.5281/zenodo.16815639)
[![version](https://img.shields.io/badge/version-2026.1-blue?style=flat-square)](https://github.com/ToledoEM/msigdf/releases)

**Important Notices**

- MSigDB v2026.1 is based on gene annotation data from Ensembl Release
  115.
- Human release notes:
  <https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_2026.1.Hs/>
- Mouse release notes:
  <https://docs.gsea-msigdb.org/#MSigDB/Release_Notes/MSigDB_2026.1.Mm/>

## Installation

``` r

# Install pak if you don't already have it 
# install_github() was deprecated in devtools 2.5.0.
install.packages("pak")

# Just get the data
pak::pak("toledoem/msigdf")

# Get the data and the suggested packages used by the vignettes
pak::pak("toledoem/msigdf", dependencies = TRUE)
```

## Data

| Object | Columns | Description |
|----|----|----|
| `msigdf.human` | `category_code`, `category_subcode`, `geneset`, `symbol` | Human gene sets (`h`, `c1`-`c9`) |
| `msigdf.mouse` | `category_code`, `category_subcode`, `geneset`, `symbol` | Mouse gene sets (`mh`, `m1`-`m8`) |
| `msigdf.urls` | `category_code`, `category_subcode`, `geneset`, `url` | MSigDB page for each human gene set |
| `msigdf.mouse.urls` | `category_code`, `category_subcode`, `geneset`, `url` | MSigDB page for each mouse gene set |

Hallmark is `h` for human and `mh` for mouse. KEGG gene sets are
human-only.

## Example usage

See the [package
vignette](https://toledoem.github.io/msigdf/articles/msigdf.html) for
more examples, or [Using msigdf with enrichment
tools](https://toledoem.github.io/msigdf/articles/gsea-workflows.html)
to feed these tables into `fgsea` or `clusterProfiler`.

``` r

library(dplyr)
library(msigdf)
#vignette("msigdf")
```

``` r

msigdf.human %>%
  filter(category_code=="h") %>%
  head
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

``` r
> msigdf.human %>% 
    filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING") %>% 
      group_by(category_subcode) %>% 
        top_n(n = 10)
```

**Since now there are legacy and KEGG gene sets**

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

## Building

Code for building this data is in `data-raw/`. Update
`data-raw/data_url.yml` with the new MSigDB version and URLs — the
top-level `version:` key drives every version-dependent pattern in both
scripts, so it is the only place a release bump needs to be made.

1.  Download the GMT files (run from the repository root):

``` bash
bash data-raw/get_gmt.sh
```

The script verifies that every file listed in the YAML was downloaded
and that each carries the declared version, so a stale URL list fails
loudly instead of silently producing empty data frames.

2.  Build the data frames and save to `data/`:

``` bash
Rscript data-raw/msigdf.R
```

3.  Regenerate documentation and check the package:

``` r

devtools::document()
devtools::check()
```

See the [package
vignette](https://toledoem.github.io/msigdf/articles/msigdf.html) for
more examples, and [Using msigdf with enrichment
tools](https://toledoem.github.io/msigdf/articles/gsea-workflows.html)
for `fgsea` and `clusterProfiler` recipes.

## License

[MSigDF](https://creativecommons.org) by
[US](https://creativecommons.org) is marked [CC0
1.0](https://creativecommons.org/publicdomain/zero/1.0/)

![CC
logo](https://mirrors.creativecommons.org/presskit/icons/cc.svg)![Zero
logo](https://mirrors.creativecommons.org/presskit/icons/zero.svg)
