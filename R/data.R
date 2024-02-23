#' @importFrom tibble tibble
NULL

#' MSigDB in a data frame (human) by gene symbol
#'
#' MSigDB in a data frame (human)
#'
#' @source \url{http://software.broadinstitute.org/gsea/msigdb/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset} and \code{symbol}. See vignette for more details.
"msigdf.human"

#' MSigDB in a data frame (mouse) by gene symbol
#'
#' MSigDB in a data frame (mouse)
#'
#' @source \url{http://software.broadinstitute.org/gsea/msigdb/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset} and \code{symbol}. See vignette for more details.
"msigdf.mouse"

#' Links to MSigDB website human gene sets
#'
#' Data frame linking each gene set name to the MSigDB website
#'
#' @source \url{https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{url}. See vignette for more details.
"msigdf.urls"

#' Links to MSigDB website mouse gene sets
#'
#' Data frame linking each gene set name to the MSigDB website
#'
#' @source \url{https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{url}. See vignette for more details.
"msigdf.mouse.urls"

