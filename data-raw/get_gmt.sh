#!/bin/bash

if [ ! -d "gmt" ]; then
	mkdir gmt
fi

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c1.all.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.reactome.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.pid.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.kegg.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.biocarta.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cgp.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c2.cp.wikipathways.v7.2.symbols.gmt

wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.mir.mirdb.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.gtrd.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c3.tft.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cm.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c4.cgn.v7.2.symbols.gmt

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.mf.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.cc.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.bp.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c5.hpo.v7.2.symbols.gmt

wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c6.all.v7.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c7.all.v7.2.symbols.gmt
wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/c8.all.v7.2.symbols.gmt

wget -p gmt/ ftp://ftp.broadinstitute.org/distribution/gsea/gene_sets/h.all.v7.2.symbols.gmt