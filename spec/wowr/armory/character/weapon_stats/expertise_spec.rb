require 'spec_helper'

module Wowr::Armory::Character::WeaponStats
  describe Expertise do
    subject { Expertise.new(fake_element) }

    its(:additional) { should satisfy { |v| v > 0 && v < 100 } }
    its(:percent)    { should be_percentage }
    its(:rating)     { should satisfy { |v| v > 0 && v < 1000 } }
    its(:value)      { should satisfy { |v| v > 0 && v < 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/baud_mal_ganis.xml')
      (Nokogiri::XML(xml)%'melee'/'expertise')[0]
    end
  end
end
