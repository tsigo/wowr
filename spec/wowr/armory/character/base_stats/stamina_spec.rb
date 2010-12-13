require 'spec_helper'

module Wowr::Armory::Character::BaseStats
  describe Stamina do
    subject { Stamina.new(fake_element) }

    its(:base)       { should satisfy { |v| v > 0 && v < 300} }
    its(:effective)  { should satisfy { |v| v > 0 && v < 8000 } }
    its(:health)     { should satisfy { |v| v > 0 && v < 100_000 } }
    its(:pet_bonus)  { should satisfy { |v| v > 0 && v < 3000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'baseStats'%'stamina')
    end
  end
end
