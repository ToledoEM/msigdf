#!/bin/bash
# DO NOT RUN
# Example code


<<<<<<< Updated upstream

wget -P gmt/ https://www.gsea-msigdb.org/gsea/msigdb/download_file.jsp?filePath=/msigdb/release/2023.2.Mm/msigdb_v2023.2.Mm_files_to_download_locally.zip
wget -P gmt/ https://www.gsea-msigdb.org/gsea/msigdb/download_file.jsp?filePath=/msigdb/release/2023.2.Hs/msigdb_v2023.2.Hs_files_to_download_locally.zip

unzip *

mv msigdb_v2023.2.Mm_files_to_download_locally/ mouse/
mv msigdb_v2023.2.Hs_files_to_download_locally/ human/

#
#
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mir_legacy.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.tft_legacy.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.bp.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.cc.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.mf.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.immunesigdb.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.vax.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.all.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v2022.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mir_legacy.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.tft_legacy.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.bp.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.cc.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.mf.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.immunesigdb.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.vax.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v2023.1.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg_legacy.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg_medicus.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mir_legacy.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.tft_legacy.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.3ca.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.bp.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.cc.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.mf.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.immunesigdb.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.vax.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v2023.2.Hs.symbols.gmt
# ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v2023.2.Hs.symbols.gmt


=======
#if [ ! -d "gmt" ]; then
#	mkdir gmt
#fi

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v7.4.symbols.gmt

wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v7.4.symbols.gmt

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.mf.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.cc.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.bp.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v7.4.symbols.gmt

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v7.4.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v7.4.symbols.gmt

wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v7.4.symbols.gmt
>>>>>>> Stashed changes
