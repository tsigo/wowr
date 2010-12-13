require 'spec_helper'

module Wowr::Armory::Character::BaseStats
  describe Intellect do
    subject { Intellect.new(fake_element) }

    its(:base)             { should satisfy { |v| v > 0 } }
    its(:effective)        { should satisfy { |v| v > 0 } }
    its(:mana)             { should satisfy { |v| v > 30000 } }
    its(:crit_hit_percent) { should be_percentage }
    its(:pet_bonus)        { should satisfy { |v| v > 0 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Nokogiri::XML(xml)%'baseStats'%'intellect')
    end
  end
end
