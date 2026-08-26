# Example usage of the msigdf package, for human and mouse data.
#
# Collection codes differ between organisms:
#   human  h, c1-c9      (hallmark is "h")
#   mouse  mh, m1-m8     (hallmark is "mh")

library(dplyr)
library(tibble)
library(purrr)
library(msigdf)

# Show first few rows for both human and mouse gene sets
msigdf.human %>% slice_head(n = 5)
msigdf.mouse %>% slice_head(n = 5)

# Filter for a specific KEGG pathway. KEGG sets are human-only; the mouse
# collections carry Reactome, WikiPathways and BioCarta instead.
msigdf.human %>%
  filter(geneset == "KEGG_NON_HOMOLOGOUS_END_JOINING")

msigdf.mouse %>%
  filter(geneset == "REACTOME_NONHOMOLOGOUS_END_JOINING_NHEJ")

# Get gene symbols as a named list for the hallmark collections
human_hallmark <- msigdf.human %>%
  filter(category_code == "h") %>%
  select(geneset, symbol) %>%
  group_by(geneset) %>%
  summarize(symbols = list(symbol), .groups = "drop") %>%
  deframe()

mouse_hallmark <- msigdf.mouse %>%
  filter(category_code == "mh") %>%
  select(geneset, symbol) %>%
  group_by(geneset) %>%
  summarize(symbols = list(symbol), .groups = "drop") %>%
  deframe()

# Show first 3 gene sets and their first 3 symbols
map(human_hallmark[1:3], head, 3)
map(mouse_hallmark[1:3], head, 3)

# Count gene sets by collection and sub-collection for both species
msigdf.human %>%
  count(category_code, category_subcode, sort = TRUE)

msigdf.mouse %>%
  count(category_code, category_subcode, sort = TRUE)

# Join with URLs for a specific hallmark set (Notch signaling).
# Both organisms have HALLMARK_* sets, under "h" and "mh" respectively.
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

print(human_notch_url)
print(mouse_notch_url)

# List KEGG pathways sorted by number of genes (human), and the mouse
# equivalent using Reactome.
msigdf.human %>%
  filter(category_code == "c2", grepl("^KEGG_", geneset)) %>%
  count(geneset, sort = TRUE)

msigdf.mouse %>%
  filter(category_code == "m2", category_subcode == "cp.reactome") %>%
  count(geneset, sort = TRUE)
