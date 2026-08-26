library(testthat)
library(dplyr)

test_that("msigdf.human has expected structure and content", {
  expect_true(exists("msigdf.human"))
  expect_s3_class(msigdf.human, "tbl_df")
  expect_true(all(c("category_code", "category_subcode", "geneset", "symbol") %in% colnames(msigdf.human)))
  expect_gt(nrow(msigdf.human), 1000)
  expect_true("HALLMARK_TNFA_SIGNALING_VIA_NFKB" %in% msigdf.human$geneset)
})

test_that("msigdf.mouse has expected structure and content", {
  expect_true(exists("msigdf.mouse"))
  expect_s3_class(msigdf.mouse, "tbl_df")
  expect_true(all(c("category_code", "category_subcode", "geneset", "symbol") %in% colnames(msigdf.mouse)))
  expect_gt(nrow(msigdf.mouse), 1000)
})

test_that("msigdf.urls has expected structure and content", {
  expect_true(exists("msigdf.urls"))
  expect_s3_class(msigdf.urls, "tbl_df")
  expect_true(all(c("category_code", "category_subcode", "geneset", "url") %in% colnames(msigdf.urls)))
  expect_gt(nrow(msigdf.urls), 100)
})

test_that("msigdf.mouse.urls has expected structure and content", {
  expect_true(exists("msigdf.mouse.urls"))
  expect_s3_class(msigdf.mouse.urls, "tbl_df")
  expect_true(all(c("category_code", "category_subcode", "geneset", "url") %in% colnames(msigdf.mouse.urls)))
  expect_gt(nrow(msigdf.mouse.urls), 100)
})

# Example test inspired by vignette: filter for a specific KEGG pathway

test_that("Filtering for KEGG_NON_HOMOLOGOUS_END_JOINING returns expected results", {
  kegg_human <- msigdf.human %>% dplyr::filter(geneset == "KEGG_NON_HOMOLOGOUS_END_JOINING")
  expect_gt(nrow(kegg_human), 5)
  expect_true("XRCC4" %in% kegg_human$symbol)
})

# Example test: group and tally

test_that("Grouping and tallying works for msigdf.human", {
  tallied <- msigdf.human %>% dplyr::group_by(category_code, category_subcode) %>% dplyr::tally()
  expect_s3_class(tallied, "tbl_df")
  expect_true(all(c("category_code", "category_subcode", "n") %in% colnames(tallied)))
})

# Example test: join with urls

test_that("Joining msigdf.human with msigdf.urls returns valid URLs", {
  joined <- msigdf.human %>%
    dplyr::filter(geneset == "HALLMARK_NOTCH_SIGNALING") %>%
    dplyr::distinct(geneset) %>%
    dplyr::left_join(msigdf.urls, by = "geneset")
  expect_true(all(!is.na(joined$url)))
  expect_true(any(grepl("NOTCH", joined$url, ignore.case = TRUE)))
})

test_that("no missing values in any dataset", {
  expect_false(any(is.na(msigdf.human)))
  expect_false(any(is.na(msigdf.mouse)))
  expect_false(any(is.na(msigdf.urls)))
  expect_false(any(is.na(msigdf.mouse.urls)))
})

test_that("every geneset has a matching URL", {
  expect_length(setdiff(unique(msigdf.human$geneset), unique(msigdf.urls$geneset)), 0)
  expect_length(setdiff(unique(msigdf.mouse$geneset), unique(msigdf.mouse.urls$geneset)), 0)
})

test_that("category codes are within the expected MSigDB collections", {
  # A bad separate() after a version bump shows up here first.
  expect_setequal(
    unique(msigdf.human$category_code),
    c("h", paste0("c", 1:9))
  )
  expect_setequal(
    unique(msigdf.mouse$category_code),
    c("mh", paste0("m", c(1, 2, 3, 5, 7, 8)))
  )
})

test_that("hallmark collections carry the expected 50 gene sets", {
  expect_equal(dplyr::n_distinct(msigdf.human$geneset[msigdf.human$category_code == "h"]), 50)
  expect_equal(dplyr::n_distinct(msigdf.mouse$geneset[msigdf.mouse$category_code == "mh"]), 50)
})

test_that("URLs are well formed", {
  expect_true(all(grepl("^https?://", msigdf.urls$url)))
  expect_true(all(grepl("^https://", msigdf.mouse.urls$url)))
  # The geneset name is the last path segment of its URL.
  expect_true(all(basename(msigdf.urls$url) == msigdf.urls$geneset))
  expect_true(all(basename(msigdf.mouse.urls$url) == msigdf.mouse.urls$geneset))
})

test_that("data_url.yml version matches URLs", {
  find_repo_root <- function(start = getwd()) {
    path <- normalizePath(start, winslash = "/", mustWork = FALSE)
    for (i in seq_len(10)) {
      if (file.exists(file.path(path, "DESCRIPTION"))) {
        return(path)
      }
      parent <- dirname(path)
      if (parent == path) {
        break
      }
      path <- parent
    }
    NA_character_
  }

  repo_root <- find_repo_root()
  yaml_path <- if (!is.na(repo_root)) {
    file.path(repo_root, "data-raw", "data_url.yml")
  } else {
    "data-raw/data_url.yml"
  }
  skip_if_not(file.exists(yaml_path))

  lines <- readLines(yaml_path, warn = FALSE)
  version_line <- lines[grep("^version:", lines)]
  expect_true(length(version_line) == 1)

  version <- trimws(sub("^version:\\s*", "", version_line))
  expect_gt(nchar(version), 0)

  url_lines <- grep("^\\s*-\\s*(ftp|https?)://", lines, value = TRUE)
  urls <- sub("^\\s*-\\s*", "", url_lines)

  version_pattern <- paste0("v", gsub("\\.", "\\\\.", version), "\\.")
  expect_true(all(grepl(version_pattern, urls)))
})
