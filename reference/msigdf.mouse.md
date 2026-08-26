# MSigDB in a data frame (mouse) by gene symbol

A data frame containing the Molecular Signatures Database (MSigDB) gene
sets for mouse, with gene symbols.

## Usage

``` r
msigdf.mouse
```

## Format

A data frame with 4 variables: `category_code`, `category_subcode`,
`geneset`, and `symbol`.

## Source

<https://www.gsea-msigdb.org/gsea/msigdb/>

## Examples

``` r
head(msigdf.mouse)
#> # A tibble: 6 × 4
#>   category_code category_subcode geneset symbol 
#>   <chr>         <chr>            <chr>   <chr>  
#> 1 m1            all              MT      mt-Atp6
#> 2 m1            all              MT      mt-Atp8
#> 3 m1            all              MT      mt-Co1 
#> 4 m1            all              MT      mt-Co2 
#> 5 m1            all              MT      mt-Co3 
#> 6 m1            all              MT      mt-Cytb
```
