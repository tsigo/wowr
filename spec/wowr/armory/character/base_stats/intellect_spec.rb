require 'spec_helper'

module Wowr::Armory::Character::BaseStats
  describe Intellect do
    subject { Intellect.new(fake_element) }

    its(:base)             { should satisfy { |v| v > 0 && v < 300} }
    its(:effective)        { should satisfy { |v| v > 0 && v < 3000 } }
    its(:mana)             { should satisfy { |v| v > 30000 } }
    its(:crit_hit_percent) { should satisfy { |v| v.kind_of?(Float) && v > 10.00 } }
    its(:pet_bonus)        { should satisfy { |v| v > 0 && v < 1000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Hpricot.XML(xml)%'baseStats'%'intellect')
    end
  end
end
