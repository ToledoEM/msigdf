<<<<<<< HEAD
## ---- include=FALSE--------------------------------------------------------
library(knitr)
opts_chunk$set(message=FALSE, warning=FALSE, eval=TRUE, echo=TRUE)

## --------------------------------------------------------------------------
library(tidyverse)
library(msigdf)

## --------------------------------------------------------------------------
msigdf.human %>% head()
msigdf.mouse %>% head()
msigdf.urls %>% as.data.frame() %>% head()

## --------------------------------------------------------------------------
msigdf.human %>% 
  filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")

## --------------------------------------------------------------------------
msigdf.human %>% 
  filter(category_code=="hallmark") %>% 
  select(geneset, symbol) %>% 
  group_by(geneset) %>% 
  summarize(entrez=list(symbol)) %>% 
  deframe() %>% 
  head() %>% 
  map(head)

## --------------------------------------------------------------------------
msigdf <- bind_rows(
  msigdf.human %>% mutate(org="human"),
  msigdf.mouse %>% rename(symbol=mouse.symbol) %>% mutate(org="mouse")
)

## --------------------------------------------------------------------------
head(msigdf)
tail(msigdf)

## --------------------------------------------------------------------------
msigdf %>%
  group_by(org, category_code) %>%
  summarize(ngenesets=n_distinct(geneset)) %>%
  tidyr::spread(org, ngenesets)

## --------------------------------------------------------------------------
msigdf %>%
  count(org, category_code) %>%
  tidyr::spread(org, n)

## --------------------------------------------------------------------------
msigdf %>%
  count(org, category_code, geneset) %>%
  filter(category_code=="hallmark") %>%
  tidyr::spread(org, n)

## --------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="hallmark") %>%
  count(geneset) %>%
  arrange(n) %>%
  head(1) %>%
  inner_join(msigdf.urls, by="geneset") %>%
  pull(url)

## --------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="c2" & grepl("^KEGG_", geneset)) %>%
  count(geneset) %>% 
  arrange(desc(n))

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

=======
## ---- include=FALSE--------------------------------------------------------
library(knitr)
opts_chunk$set(message=FALSE, warning=FALSE, eval=TRUE, echo=TRUE)

## --------------------------------------------------------------------------
library(tidyverse)
library(msigdf)

## --------------------------------------------------------------------------
msigdf.human %>% head()
msigdf.mouse %>% head()
msigdf.urls %>% as.data.frame() %>% head()

## --------------------------------------------------------------------------
msigdf.human %>% 
  filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")

## --------------------------------------------------------------------------
msigdf.human %>% 
  filter(category_code=="hallmark") %>% 
  select(geneset, symbol) %>% 
  group_by(geneset) %>% 
  summarize(entrez=list(symbol)) %>% 
  deframe() %>% 
  head() %>% 
  map(head)

## --------------------------------------------------------------------------
msigdf <- bind_rows(
  msigdf.human %>% mutate(org="human"),
  msigdf.mouse %>% rename(symbol=mouse.symbol) %>% mutate(org="mouse")
)

## --------------------------------------------------------------------------
head(msigdf)
tail(msigdf)

## --------------------------------------------------------------------------
msigdf %>%
  group_by(org, category_code) %>%
  summarize(ngenesets=n_distinct(geneset)) %>%
  tidyr::spread(org, ngenesets)

## --------------------------------------------------------------------------
msigdf %>%
  count(org, category_code) %>%
  tidyr::spread(org, n)

## --------------------------------------------------------------------------
msigdf %>%
  count(org, category_code, geneset) %>%
  filter(category_code=="hallmark") %>%
  tidyr::spread(org, n)

## --------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="hallmark") %>%
  count(geneset) %>%
  arrange(n) %>%
  head(1) %>%
  inner_join(msigdf.urls, by="geneset") %>%
  pull(url)

## --------------------------------------------------------------------------
msigdf.human %>%
  filter(category_code=="c2" & grepl("^KEGG_", geneset)) %>%
  count(geneset) %>% 
  arrange(desc(n))

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

>>>>>>> 1f7c302c375fd509c97d3dc3da69904ce6c85efc
