drop table
    ec_cross_references,
    embl_cross_references,
    go_cross_references,
    interpro_cross_references,
    ec_numbers,
    go_terms,
    interpro_entries,
    go_lcas,
    interpro_to_gos,
    kegg_pathways,
    kegg_pathway_mappings,
    lineages,
    peptides,
    refseq_cross_references,
    sequences,
    taxons,
    uniprot_entries,
    proteomes,
    proteome_cross_references,
    proteome_caches;

rename table unipept2.ec_cross_references to unipept.ec_cross_references;
rename table unipept2.embl_cross_references to unipept.embl_cross_references;
rename table unipept2.go_cross_references to unipept.go_cross_references;
rename table unipept2.interpro_cross_references to unipept.interpro_cross_references;
rename table unipept2.ec_numbers to unipept.ec_numbers;
rename table unipept2.go_terms to unipept.go_terms;
rename table unipept2.interpro_entries to unipept.interpro_entries;
rename table unipept2.go_lcas to unipept.go_lcas;
rename table unipept2.interpro_to_gos to unipept.interpro_to_gos;
rename table unipept2.kegg_pathways to unipept.kegg_pathways;
rename table unipept2.kegg_pathway_mappings to unipept.kegg_pathway_mappings;
rename table unipept2.lineages to unipept.lineages;
rename table unipept2.peptides to unipept.peptides;
rename table unipept2.refseq_cross_references to unipept.refseq_cross_references;
rename table unipept2.sequences to unipept.sequences;
rename table unipept2.taxons to unipept.taxons;
rename table unipept2.uniprot_entries to unipept.uniprot_entries;
rename table unipept2.proteomes to unipept.proteomes;
rename table unipept2.proteome_cross_references to unipept.proteome_cross_references;
rename table unipept2.proteome_caches to unipept.proteome_caches;
