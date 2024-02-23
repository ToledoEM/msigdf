## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(message=FALSE, warning=FALSE, eval=TRUE, echo=TRUE)

## -----------------------------------------------------------------------------
library(tidyverse)
library(msigdf)

## -----------------------------------------------------------------------------
msigdf.human %>% head()
msigdf.mouse %>% head()
msigdf.urls %>% as.data.frame() %>% head()

## -----------------------------------------------------------------------------
msigdf.human %>% 
  filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")

## -----------------------------------------------------------------------------
msigdf.human %>% 
  filter(category_code=="c2") %>% 
  select(geneset, symbol) %>% 
  group_by(geneset) %>% 
  summarize(symbol=list(symbol)) %>% 
  deframe() %>% 
  head() %>% 
  map(head)

## -----------------------------------------------------------------------------
msigdf.human %>%
  group_by(category_code,category_subcode) %>% 
  tally()

## -----------------------------------------------------------------------------
msigdf.mouse %>%
  group_by(category_code,category_subcode) %>% 
  tally()

## -----------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="h") %>%
  count(geneset) %>%
  arrange(n) %>%
  head(1) %>%
  inner_join(msigdf.urls, by="geneset") %>%
  pull(url)

## -----------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="c2" & grepl("^KEGG_", geneset)) %>%
  count(geneset) %>% 
  arrange(desc(n))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

