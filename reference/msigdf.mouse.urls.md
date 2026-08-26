# Links to MSigDB website mouse gene sets

Data frame linking each mouse gene set name to the MSigDB website.

## Usage

``` r
msigdf.mouse.urls
```

## Format

A data frame with 4 variables: `category_code`, `category_subcode`,
`geneset`, and `url`.

## Source

<https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/>

## Examples

``` r
head(msigdf.mouse.urls)
#> # A tibble: 6 × 4
#>   category_code category_subcode geneset url                                    
#>   <chr>         <chr>            <chr>   <chr>                                  
#> 1 m1            all              MT      https://www.gsea-msigdb.org/gsea/msigd…
#> 2 m1            all              chr10A1 https://www.gsea-msigdb.org/gsea/msigd…
#> 3 m1            all              chr10A2 https://www.gsea-msigdb.org/gsea/msigd…
#> 4 m1            all              chr10A3 https://www.gsea-msigdb.org/gsea/msigd…
#> 5 m1            all              chr10A4 https://www.gsea-msigdb.org/gsea/msigd…
#> 6 m1            all              chr10B1 https://www.gsea-msigdb.org/gsea/msigd…
```
