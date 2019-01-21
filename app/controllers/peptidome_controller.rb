class PeptidomeController < ApplicationController
  def analyze
    @header_class = 'peptidome'
    @tab = params[:tab]
    if @tab == 'peptidefinder'
      @title = 'Unique Peptide Finder'
    elsif @tab == 'peptidomeclustering'
      @title = 'Peptidome Clustering'
    else
      @title = 'Peptidome Analysis'
      @tab = 'peptidefinder'
    end

    @taxa = Proteome.json_taxa
    @proteomes = Proteome.json_proteomes
  end

  # Returns a list of all sequence_ids for a given proteome_id
  def get_sequence_ids_for_proteome
    cache = ProteomeCache.get_encoded_sequences(params[:proteome_id])
    respond_to do |format|
      format.json { render json: cache.json_sequences }
    end
  end

  # Returns a filtered list of unique sequence id's for a given LCA
  def get_unique_sequences
    sequences = if params[:proteome_id].nil?
                  ProteomeCache.delta_decode(JSON(params[:sequences]))
                else
                  ProteomeCache.get_decoded_sequences(params[:proteome_id])
                end
    if !params[:ids].empty?
      lca = Lineage.calculate_lca(Lineage.find_by_sql("SELECT lineages.* from proteomes LEFT JOIN lineages ON proteomes.taxon_id = lineages.taxon_id WHERE proteomes.id IN (#{params[:ids]}) AND proteomes.taxon_id is not null"))
      result = ProteomeCache.delta_encode(Sequence.filter_unique_uniprot_peptides(sequences, lca))
      lca = Taxon.find_by(id: lca).name
    else
      lca = 'undefined'
      result = []
    end
    render json: Oj.dump([lca, result], mode: :rails)
  end

  # Returns a list of sequences
  def get_sequences
    ids = ProteomeCache.delta_decode(JSON(params[:sequence_ids]))
    render json: Oj.dump(Sequence.list_sequences(ids).join("\n"), mode: :rails)
  end

  # Returns a list of proteins
  def get_proteins
    ids = ProteomeCache.delta_decode(JSON(params[:sequence_ids]))
    sequences = Sequence.includes(original_peptides: :uniprot_entry).where(id: ids)
    data = sequences.map { |sequence| [sequence, sequence.original_peptides.map(&:uniprot_entry)] }
    csv_string = CSV.generate_line %w[sequence lca_taxon_id uniprot_id protein_name]
    data.each do |sequence, proteins|
      proteins.each do |uniprot_entry|
        csv_string += CSV.generate_line [sequence.sequence, sequence.lca, uniprot_entry.uniprot_accession_number, uniprot_entry.name]
      end
    end
    render json: Oj.dump(csv_string, mode: :rails)
  end

  # Converts a list of peptides to id's
  def convert_peptides
    peptides = JSON(params[:peptides]) rescue ''
    ids = Sequence.where(sequence: peptides).pluck(:id)
    render json: Oj.dump(ids, mode: :rails)
  end

  # Calculates the LCA of a list of bioproject id's
  def get_lca
    params[:ids] = [] if params[:ids].nil?
    if !params[:ids].empty?
      lca = Lineage.calculate_lca(Lineage.find_by_sql("SELECT lineages.* from proteomes LEFT JOIN lineages ON proteomes.taxon_id = lineages.taxon_id WHERE proteomes.id IN (#{params[:ids]}) AND proteomes.taxon_id is not null"))
      lca = Taxon.find_by(id: lca)
    else
      lca = { name: 'undefined' }
    end
    render json: Oj.dump(lca, mode: :rails)
  end
end
