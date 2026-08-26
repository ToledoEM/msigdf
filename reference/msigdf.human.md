# MSigDB in a data frame (human) by gene symbol

A data frame containing the Molecular Signatures Database (MSigDB) gene
sets for human, with gene symbols.

## Usage

``` r
msigdf.human
```

## Format

A data frame with 4 variables: `category_code`, `category_subcode`,
`geneset`, and `symbol`.

## Source

<https://www.gsea-msigdb.org/gsea/msigdb/>

## Examples

``` r
head(msigdf.human)
#> # A tibble: 6 × 4
#>   category_code category_subcode geneset symbol 
#>   <chr>         <chr>            <chr>   <chr>  
#> 1 c1            all              MT      MT-ATP6
#> 2 c1            all              MT      MT-ATP8
#> 3 c1            all              MT      MT-CO1 
#> 4 c1            all              MT      MT-CO2 
#> 5 c1            all              MT      MT-CO3 
#> 6 c1            all              MT      MT-CYB 
```
