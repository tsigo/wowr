require 'spec_helper'

module Wowr::Armory::Character
  describe Defenses do
    subject { Defenses.new(fake_element) }

    its(:armor)      { should be_kind_of(DefenseStats::Armor) }
    its(:defense)    { should be_kind_of(DefenseStats::Defense) }
    its(:dodge)      { should be_kind_of(DefenseStats::Avoidance) }
    its(:parry)      { should be_kind_of(DefenseStats::Avoidance) }
    its(:block)      { should be_kind_of(DefenseStats::Avoidance) }
    its(:resilience) { should be_kind_of(DefenseStats::Resilience) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses')
    end
  end
end
