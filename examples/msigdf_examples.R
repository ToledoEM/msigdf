# Example usage of msigdf package with improved and parallel code for human and mouse data

library(tidyverse)
library(msigdf)

# Show first few rows for both human and mouse gene sets
msigdf.human %>% slice_head(n = 5)
msigdf.mouse %>% slice_head(n = 5)

# Filter for a specific KEGG pathway in both human and mouse
msigdf.human %>%
  filter(geneset == "KEGG_NON_HOMOLOGOUS_END_JOINING")

msigdf.mouse %>%
  filter(geneset == "KEGG_NON_HOMOLOGOUS_END_JOINING")

# Get gene symbols as a named list for Hallmark sets (human) and for mouse
human_hallmark <- msigdf.human %>%
  filter(category_code == "hallmark") %>%
  select(geneset, symbol) %>%
  group_by(geneset) %>%
  summarize(symbols = list(symbol), .groups = "drop") %>%
  deframe()

mouse_hallmark <- msigdf.mouse %>%
  filter(category_code == "hallmark") %>%
  select(geneset, symbol) %>%
  group_by(geneset) %>%
  summarize(symbols = list(symbol), .groups = "drop") %>%
  deframe()

# Show first 3 gene sets and their first 3 symbols
purrr::map(human_hallmark[1:3], head, 3)
purrr::map(mouse_hallmark[1:3], head, 3)

# Count gene sets by collection and sub-collection for both species
msigdf.human %>%
  count(category_code, category_subcode, sort = TRUE)

msigdf.mouse %>%
  count(category_code, category_subcode, sort = TRUE)

# Join with URLs for a specific hallmark set (Notch signaling) in human and mouse
human_notch_url <- msigdf.human %>%
  filter(geneset == "HALLMARK_NOTCH_SIGNALING") %>%
  distinct(geneset) %>%
  left_join(msigdf.urls, by = "geneset") %>%
  pull(url)

mouse_notch_url <- msigdf.mouse %>%
  filter(geneset == "HALLMARK_NOTCH_SIGNALING") %>%
  distinct(geneset) %>%
  left_join(msigdf.mouse.urls, by = "geneset") %>%
  pull(url)

# Print URLs
print(human_notch_url)
print(mouse_notch_url)

# List KEGG pathways sorted by number of genes (human and mouse)
msigdf.human %>%
  filter(category_code == "c2", str_starts(geneset, "KEGG_")) %>%
  count(geneset, sort = TRUE)

msigdf.mouse %>%
  filter(category_code == "m2", str_starts(geneset, "KEGG_")) %>%
  count(geneset, sort = TRUE)
