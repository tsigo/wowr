require 'spec_helper'

module Wowr::Armory::Character::SpellStats
  describe Damage do
    subject { Damage.new(*fake_element) }

    its(:value)               { should satisfy { |v| v > 3000 } }
    its(:crit_chance_percent) { should be_percentage }

    # Aliased methods
    its(:percent) { should_not be_nil }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      elem = (Nokogiri::XML(xml)%'spell')

      [elem%'bonusDamage'%'shadow', elem%'critChance'%'shadow']
    end

  end
end
