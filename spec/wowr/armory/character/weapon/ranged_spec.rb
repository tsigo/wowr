require 'spec_helper'

module Wowr::Armory::Character::Weapon
  describe Ranged do
    subject { Ranged.new(fake_element) }

    its(:weapon_skill) { should be_kind_of(Skill) }
    its(:damage)       { should be_kind_of(Damage) }
    its(:speed)        { should be_kind_of(Speed) }
    its(:power)        { should be_kind_of(Power) }
    its(:hit_rating)   { should be_kind_of(HitRating) }
    its(:crit_chance)  { should be_kind_of(CritChance) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'ranged')
    end
  end
end
