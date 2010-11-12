require 'spec_helper'

module Wowr::Armory::Character::DefenseStats
  describe Resilience do
    subject { Resilience.new(fake_element) }

    its(:damage_percent) { should eql(0.00) }
    its(:hit_percent) { should eql(0.00) }
    its(:value) { should eql(0.00) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'defenses'%'resilience')
    end
  end
end
