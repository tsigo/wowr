require 'spec_helper'

module Wowr::Armory::Character::Weapon
  describe Melee do
    subject { Melee.new(fake_element) }

    its(:main_hand_damage) { should be_kind_of(Damage) }
    its(:off_hand_damage)  { should be_kind_of(Damage) }
    its(:main_hand_speed)  { should be_kind_of(Speed) }
    its(:off_hand_speed)   { should be_kind_of(Speed) }
    its(:power)            { should be_kind_of(Power) }
    its(:hit_rating)       { should be_kind_of(HitRating) }
    its(:crit_chance)      { should be_kind_of(CritChance) }
    its(:expertise)        { should be_kind_of(Expertise) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'melee')
    end
  end
end
