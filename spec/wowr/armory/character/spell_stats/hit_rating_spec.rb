require 'spec_helper'

module Wowr::Armory::Character::SpellStats
  describe HitRating do
    subject { HitRating.new(fake_element) }

    its(:increased_hit_percent) { should be_percentage }
    its(:penetration)           { should satisfy { |v| v >= 0 } }
    its(:reduced_resist)        { should satisfy { |v| v >= 0 } }
    its(:value)                 { should satisfy { |v| v >= 0 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Nokogiri::XML(xml)%'spell'/'hitRating')[0]
    end
  end
end
