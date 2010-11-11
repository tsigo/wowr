require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe HitRating do
    subject { HitRating.new(fake_element) }

    its(:increased_hit_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:armor_penetration)     { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:value)                 { should satisfy { |v| v > 0 && v < 1000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/baud_mal_ganis.xml')
      (Hpricot.XML(xml)%'melee'/'hitRating')[0]
    end
  end
end
