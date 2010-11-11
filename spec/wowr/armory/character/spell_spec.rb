require 'spec_helper'

module Wowr::Armory::Character
  describe Spell do
    subject { Spell.new(fake_element) }

    Wowr::Armory::ELEMENT_TYPES.each do |element|
      its(element) { should be_kind_of(SpellStats::Damage) }
    end

    its(:bonus_healing) { should be_kind_of(Integer) }
    its(:penetration)   { should be_kind_of(Integer) }
    its(:hit_rating)    { should be_kind_of(SpellStats::HitRating) }
    its(:mana_regen)    { should be_kind_of(SpellStats::ManaRegen) }
    its(:speed)         { should be_kind_of(SpellStats::Speed) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Hpricot.XML(xml)%'spell')
    end

  end
end
