#!/bin/bash

if [ ! -d "gmt" ]; then
	mkdir gmt
fi


wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mir_legacy.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.tft_legacy.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.bp.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.cc.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.mf.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.go.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v7.4.symbols.gmt
#wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.immunesigdb.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.vax.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v7.4.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v7.4.symbols.gmt
