# Links to MSigDB website human gene sets

Data frame linking each human gene set name to the MSigDB website.

## Usage

``` r
msigdf.urls
```

## Format

A data frame with 4 variables: `category_code`, `category_subcode`,
`geneset`, and `url`.

## Source

<https://www.gsea-msigdb.org/gsea/msigdb/human/geneset/>

## Examples

``` r
head(msigdf.urls)
#> # A tibble: 6 × 4
#>   category_code category_subcode geneset  url                                   
#>   <chr>         <chr>            <chr>    <chr>                                 
#> 1 c1            all              MT       http://software.broadinstitute.org/gs…
#> 2 c1            all              chr10p11 http://software.broadinstitute.org/gs…
#> 3 c1            all              chr10p12 http://software.broadinstitute.org/gs…
#> 4 c1            all              chr10p13 http://software.broadinstitute.org/gs…
#> 5 c1            all              chr10p14 http://software.broadinstitute.org/gs…
#> 6 c1            all              chr10p15 http://software.broadinstitute.org/gs…
```
