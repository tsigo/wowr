require 'spec_helper'

module Wowr::Armory::Character::Defenses
  describe Defense do
    subject { Defense.new(fake_element) }

    its(:value)            { should satisfy { |v| v == 400.00 } }
    its(:increase_percent) { should satisfy { |v| v == 0.00 } }
    its(:decrease_percent) { should satisfy { |v| v == 0.00 } }
    its(:plus_defense)     { should satisfy { |v| v == 0 } }
    its(:rating)           { should satisfy { |v| v == 0 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'defense')
    end
  end
end
