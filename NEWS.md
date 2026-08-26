# msigdf

## Repo maintenance 2

Repository chores and fixes only. The data is unchanged from 2026.1 — `msigdf.human`, `msigdf.mouse`, `msigdf.urls` and `msigdf.mouse.urls` are byte-identical to the previous release.

- Fix `.Rbuildignore`: `data-raw/*$` never matched anything, so `data-raw/` and `examples/` were shipped in the built tarball. Patterns are now correctly anchored.
- Refactor `data-raw/msigdf.R`: extract the duplicated human/mouse blocks into a single `build_msigdf()` function, replace `assign()`/`eval(parse())` with a named list, and derive every version-dependent pattern from `data_url.yml`. Previously the version was read but never used, so a release bump silently produced empty data frames.
- Update the human gene set URL prefix in the build script to `https://www.gsea-msigdb.org/gsea/msigdb/human/geneset/`, replacing the retired `software.broadinstitute.org/gsea/msigdb/cards/` host. This is a build script change only — the shipped `msigdf.urls` still carries the old prefix and will pick up the new one at the next data rebuild.
- Harden `data-raw/get_gmt.sh`: add `set -euo pipefail`, resolve paths relative to the script so it runs from the repository root as documented, replace GNU-only `find -printf` with a portable equivalent, deduplicate the verification logic, and check that downloaded files match the declared version.
- Expand CI: R CMD check matrix across Linux/macOS/Windows on release and oldrel-1, with lint, test coverage, and pkgdown deployment as separate workflows.
- Add `.lintr` configuration so linting reports real issues rather than flagging the package's dotted object names.
- Convert `inst/CITATION` from deprecated `citEntry()` to `bibentry()`, and add an entry for the package itself.
- Fix vignette errors: it described three data frames containing Entrez IDs (there are four, containing gene symbols) and filtered `c2` in a section about hallmark sets.
- Add the "Using msigdf with enrichment tools" vignette covering `fgsea` and `clusterProfiler` input formats.
- Fix `examples/msigdf_examples.R`: it filtered `category_code == "hallmark"`, which matches nothing (hallmark is `h` for human, `mh` for mouse), and queried KEGG gene sets against the mouse collections, which contain none.
- Add tests for missing values, geneset/URL coverage, expected collection codes, and URL structure.
- Drop `tidyverse` and `BiocStyle` from Suggests; the vignettes now load only the packages they use.

## Repo maintenance
- Add version badge to README.
- Update GitHub Actions: `actions/checkout@v4.2.1` for Node.js 24 compatibility.
- Purged `data-raw/gmt/` from entire git history; repo size reduced from ~850MB to ~32MB. Existing clones must be re-cloned.

## 2026.1 build changes
- Read MSigDB version from data-raw/data_url.yml during builds.
- Parse URLs by section in data-raw/get_gmt.sh and report missing/extra downloads.
- Add test to validate YAML version matches URLs.
- Update README build instructions and resize CC logos.

## 2026.1
- Update data to MSigDB 2026.1.
- Add paper citations and refresh README/vignette.
- Update logo assets and .Rbuildignore.

## 2025.1
- Update data to MSigDB 2025.1.
- Add tests and expanded documentation.
- Add Zenodo metadata and improve links.

## 2024.1
- Update data to MSigDB 2024.1.
- Refresh vignette.

## 2023.2
- Update data to MSigDB 2023.2.

## 7.4
- Repository cleanup.

## 7.2
- Update data to MSigDB 7.2.

## 7.1
- Update data to MSigDB 7.1.

## 7.0
- Update data to MSigDB 7.0.

## 6.2
- Update data to MSigDB 6.2.
- Add FTP download script and remove bundled GMT/data files.

## 6.1
- Add geneset subcategory and update data to MSigDB 6.1.
- Documentation and code comments cleanup.
- Forked from https://github.com/stephenturner/msigdf/pull/1 

## 5.2
- Update data to MSigDB 5.2.
- Switch to tibble and update vignette styling/links.

## 5.1
- Initial GitHub release and MSigDB 5.1 alignment.
- README and vignette setup.
