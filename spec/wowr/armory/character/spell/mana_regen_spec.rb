require 'spec_helper'

module Wowr::Armory::Character::Spell
  describe ManaRegen do
    subject { ManaRegen.new(fake_element) }

    its(:casting)     { should satisfy { |v| v > 0.00 } }
    its(:not_casting) { should satisfy { |v| v > 0.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Hpricot.XML(xml)%'spell'/'manaRegen')[0]
    end

  end
end
