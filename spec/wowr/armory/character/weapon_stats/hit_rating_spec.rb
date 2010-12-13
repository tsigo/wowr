require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe HitRating do
    subject { HitRating.new(fake_element) }

    its(:increased_hit_percent) { should be_percentage }
    its(:armor_penetration)     { should be_percentage }
    its(:value)                 { should satisfy { |v| v > 0 && v < 1000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/baud_mal_ganis.xml')
      (Nokogiri::XML(xml)%'melee'/'hitRating')[0]
    end
  end
end
