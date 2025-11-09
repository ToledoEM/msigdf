#' @importFrom tibble tibble
NULL

#' MSigDB in a data frame (human) by gene symbol
#'
#' A data frame containing the Molecular Signatures Database (MSigDB) gene sets for human, with gene symbols.
#'
#' @docType data
#' @keywords datasets
#' @source \url{http://software.broadinstitute.org/gsea/msigdb/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{symbol}.
#' @examples
#' head(msigdf.human)
"msigdf.human"

#' MSigDB in a data frame (mouse) by gene symbol
#'
#' A data frame containing the Molecular Signatures Database (MSigDB) gene sets for mouse, with gene symbols.
#'
#' @docType data
#' @keywords datasets
#' @source \url{http://software.broadinstitute.org/gsea/msigdb/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{symbol}.
#' @examples
#' head(msigdf.mouse)
"msigdf.mouse"

#' Links to MSigDB website human gene sets
#'
#' Data frame linking each human gene set name to the MSigDB website.
#'
#' @docType data
#' @keywords datasets
#' @source \url{https://www.gsea-msigdb.org/gsea/msigdb/geneset/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{url}.
#' @examples
#' head(msigdf.urls)
"msigdf.urls"

#' Links to MSigDB website mouse gene sets
#'
#' Data frame linking each mouse gene set name to the MSigDB website.
#'
#' @docType data
#' @keywords datasets
#' @source \url{https://www.gsea-msigdb.org/gsea/msigdb/mouse/geneset/}
#' @format A data frame with 4 variables: \code{category_code}, \code{category_subcode}, \code{geneset}, and \code{url}.
#' @examples
#' head(msigdf.mouse.urls)
"msigdf.mouse.urls"

