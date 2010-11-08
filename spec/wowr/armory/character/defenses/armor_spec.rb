require 'spec_helper'

module Wowr::Armory::Character::Defenses
  describe Armor do
    subject { Armor.new(fake_element) }

    its(:base)      { should satisfy { |v| v > 0 && v < 20000 } }
    its(:effective) { should satisfy { |v| v > 0 && v < 20000 } }
    its(:percent)   { should satisfy { |v| v.kind_of?(Float) && v > 0.00 && v < 100.00 } }
    its(:pet_bonus) { should satisfy { |v| v > 0 && v < 6000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'armor')
    end
  end
end
