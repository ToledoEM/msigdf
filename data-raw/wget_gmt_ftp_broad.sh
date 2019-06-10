# Now the gmt are available in public FTP serverfo the Broad (Thanks!)
#!/bin/bash

if [ ! -d "gmt" ]; then
	mkdir gmt
fi

wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c1.all.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c2.cgp.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c2.cp.biocarta.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c2.cp.kegg.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c2.cp.reactome.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c2.cp.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c3.mir.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c3.tft.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c4.cgn.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c4.cm.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c5.bp.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c5.cc.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c5.mf.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c6.all.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/c7.all.v6.2.symbols.gmt
wget -P gmt/ ftp://ftp.broadinstitute.org/pub/gsea/gene_sets/h.all.v6.2.symbols.gmt
