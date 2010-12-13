require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe Speed do
    subject { Speed.new(fake_element) }

    its(:haste_percent) { should be_percentage }
    its(:haste_rating)  { should satisfy { |v| v > 0 && v < 2000 } }
    its(:value)         { should satisfy { |v| v > 0.00 && v < 15.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'melee'/'mainHandSpeed')[0]
    end
  end
end
