require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe Damage do
    subject { Damage.new(fake_element) }

    its(:dps)     { should satisfy { |v| v > 0.00 && v < 2000.00 } }
    its(:max)     { should satisfy { |v| v > 0 && v < 5000 } }
    its(:min)     { should satisfy { |v| v > 0 && v < 5000 } }
    its(:percent) { should eql(0.00) }
    its(:speed)   { should satisfy { |v| v > 0.00 && v < 15.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'melee'/'mainHandDamage')[0]
    end
  end
end
