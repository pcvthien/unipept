#!/usr/bin/env python3


def print_kmers(k, uniprot_entries_filename):
    for kmer_id, taxon_id in generate_kmers(k, uniprot_entries_filename):
        print(kmer_id, taxon_id, sep='\t')


def generate_kmers(k, uniprot_entries_filename):
    """Generates all possible tuples (kmer, taxon_id) for the given UniProt
    entries file.
    """
    with open(uniprot_entries_filename) as uniprot_entries_file:
        for entry in uniprot_entries_file.readlines():
            fields = entry.rstrip().split('\t')
            yield from split_into_kmers(k, fields[3], fields[-1])


def split_into_kmers(k, taxon_id, prot_sequence):
    """Generates all possible tuples (kmer, taxon_id) for a given protein
    sequence.
    """
    for i in range(len(prot_sequence) - k + 1):
        yield prot_sequence[i:i + k], taxon_id


if __name__ == "__main__":
    import sys

    k = int(sys.argv[1])
    uniprot_entries_filename = sys.argv[2]
    print_kmers(k, uniprot_entries_filename)
