require 'spec_helper'

module Wowr::Armory::Character::Stat
  describe Spirit do
    subject { Spirit.new(fake_element) }

    # Using non-exact values so that we're not constantly updating specs as the
    # character used upgrades his gear

    its(:base)          { should satisfy { |v| v > 0 && v < 300} }
    its(:effective)     { should satisfy { |v| v > 0 && v < 300 } }
    its(:health_regen)  { should satisfy { |v| v > 0 } }
    its(:mana_regen)    { should satisfy { |v| v > 0 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Hpricot.XML(xml)%'baseStats'%'spirit')
    end
  end
end
