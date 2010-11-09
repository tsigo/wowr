require 'spec_helper'

module Wowr::Armory::Character::Weapon
  describe Power do
    subject { Power.new(fake_element) }

    its(:base)          { should satisfy { |v| v > 1000 } }
    its(:effective)     { should satisfy { |v| v > 1000 } }
    its(:increased_dps) { should satisfy { |v| v > 100.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/baud_mal_ganis.xml')
      (Hpricot.XML(xml)%'melee'/'power')[0]
    end
  end
end
