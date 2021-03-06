require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe CritChance do
    subject { CritChance.new(fake_element) }

    its(:percent)      { should be_percentage }
    its(:plus_percent) { should be_percentage }
    its(:rating)       { should satisfy { |v| v > 0 && v < 3000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'melee'/'critChance')[0]
    end
  end
end
