## ---- include=FALSE------------------------------------------------------
library(knitr)
opts_chunk$set(message=FALSE, warning=FALSE, eval=TRUE, echo=TRUE)

## ------------------------------------------------------------------------
library(plyr)
library(dplyr)
library(tidyr)
library(msigdf)

## ------------------------------------------------------------------------
msigdf.human
msigdf.mouse
msigdf.urls %>% as.data.frame %>% head

## ------------------------------------------------------------------------
msigdf.human %>% 
  filter(geneset=="KEGG_NON_HOMOLOGOUS_END_JOINING")

## ------------------------------------------------------------------------
msigdf.human %>% 
  filter(collection=="hallmark") %>% 
  dlply(.variables="geneset", .fun=function(x) x$entrez) %>% 
  head(10) %>% 
  lapply(head, 5)

## ------------------------------------------------------------------------
msigdf <- bind_rows(
  msigdf.human %>% mutate(org="human"),
  msigdf.mouse %>% mutate(org="mouse")
)

## ------------------------------------------------------------------------
head(msigdf)
tail(msigdf)

## ------------------------------------------------------------------------
msigdf %>%
  group_by(org, collection) %>%
  summarize(ngenesets=n_distinct(geneset)) %>%
  spread(org, ngenesets)

## ------------------------------------------------------------------------
msigdf %>%
  count(org, collection) %>%
  spread(org, n)

## ------------------------------------------------------------------------
msigdf %>%
  count(org, collection, geneset) %>%
  filter(collection=="hallmark") %>%
  spread(org, n)

## ------------------------------------------------------------------------
msigdf.human %>%
  filter(collection=="hallmark") %>%
  count(geneset) %>%
  arrange((n)) %>%
  head(1) %>%
  inner_join(msigdf.urls, by="geneset") %>%
  .$url

## ------------------------------------------------------------------------
msigdf.human %>%
  filter(collection=="c2" & grepl("^KEGG_", geneset)) %>%
  count(geneset) %>% 
  arrange(desc(n))

