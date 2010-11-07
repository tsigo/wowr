require 'spec_helper'

module Wowr::Armory::Character::Stat
  describe Agility do
    subject { Agility.new(fake_element) }

    # Using non-exact values so that we're not constantly updating specs as the
    # character used upgrades his gear

    its(:base)             { should satisfy { |v| v > 100 && v < 300 } }
    its(:effective)        { should satisfy { |v| v > 2000 } }
    its(:armor)            { should satisfy { |v| v > 5000 } }
    its(:attack)           { should satisfy { |v| v > 2000 } }
    its(:crit_hit_percent) { should satisfy { |v| v.kind_of?(Float) && v > 10.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'baseStats'%'agility')
    end
  end
end
