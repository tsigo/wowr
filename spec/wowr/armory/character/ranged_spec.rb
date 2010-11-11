require 'spec_helper'

module Wowr::Armory::Character
  describe Ranged do
    subject { Ranged.new(fake_element) }

    its(:damage)       { should be_kind_of(WeaponStats::Damage) }
    its(:speed)        { should be_kind_of(WeaponStats::Speed) }
    its(:power)        { should be_kind_of(WeaponStats::Power) }
    its(:hit_rating)   { should be_kind_of(WeaponStats::HitRating) }
    its(:crit_chance)  { should be_kind_of(WeaponStats::CritChance) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'ranged')
    end
  end
end
