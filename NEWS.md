# msigdf

## Repo maintenance
- Add version badge to README.
- Update GitHub Actions: `actions/checkout@v4.2.1` for Node.js 24 compatibility.
- Purged `data-raw/gmt/` from entire git history; repo size reduced from ~850MB to ~32MB. Existing clones must be re-cloned.

## 2026.1 build changes (2)
- Refactor build script: extract shared human/mouse logic into single function.
- Replace `eval(parse())` with `lapply` in build script.
- Derive version regex from data_url.yml; remove hardcoded version strings.
- Move `dplyr` from Suggests to Imports in DESCRIPTION.
- Add GitHub Actions CI with R CMD check and lintr.
- Migrate `data/*.rda` to Git LFS; purge binary blobs from git history.

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
