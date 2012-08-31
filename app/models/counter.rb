# == Schema Information
#
# Table name: counters
#
#  name  :string(31)      not null, primary key
#  value :integer(4)      default(0), not null
#

class Counter < ActiveRecord::Base
  
  set_primary_key :name
  
  def self.count(max=1000)
    id = Counter.find_by_name("sequence_id")
    while id.value < max
      id.value += 1
      sequence = Sequence.find_by_id(id.value)
      if !sequence.nil? && sequence.sequence.length >= 5
        lca = sequence.calculate_lca(true)
        unless lca.nil?
          lca_taxon = Taxon.find_by_id(lca)
          c = lca_taxon.name == "root" ? Counter.find_by_name("root") : Counter.find_by_name(lca_taxon.rank);
          if !c.nil?
            c.value += 1
            c.save;
          end
        end
      else
        Peptide.delete_all("sequence_id = #{id.value}")
        Peptide.delete_all("original_sequence_id = #{id.value}")
        Sequence.delete(id.value)
      end
      id.save;
    end
  end
  
end
