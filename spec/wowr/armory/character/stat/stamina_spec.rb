require 'spec_helper'

module Wowr::Armory::Character::Stat
  describe Stamina do
    subject { Stamina.new(fake_element) }

    # Using non-exact values so that we're not constantly updating specs as the
    # character used upgrades his gear

    its(:base)       { should satisfy { |v| v > 0 && v < 300} }
    its(:effective)  { should satisfy { |v| v > 0 && v < 4000 } }
    its(:health)     { should satisfy { |v| v > 0 && v < 40000 } }
    its(:pet_bonus)  { should satisfy { |v| v > 0 && v < 1000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'baseStats'%'stamina')
    end
  end
end
