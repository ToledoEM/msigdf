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
  joined <- msigdf.human %>% dplyr::filter(geneset == "HALLMARK_NOTCH_SIGNALING") %>%
    dplyr::distinct(geneset) %>%
    dplyr::left_join(msigdf.urls, by = "geneset")
  expect_true(all(!is.na(joined$url)))
  expect_true(any(grepl("NOTCH", joined$url, ignore.case = TRUE)))
})
