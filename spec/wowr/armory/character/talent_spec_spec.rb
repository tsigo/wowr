require 'spec_helper'

module Wowr::Armory::Character
  describe TalentSpec do
    subject { TalentSpec.new(fake_element) }

    its(:active) { should be_true }
    its(:group) { should eql(2) }
    its(:primary) { should eql("Marksmanship") }
    its(:point_distribution) { should match(/^\d+$/) }

    protected

    def fake_element
      xml = file_fixture('armory/character-talents/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'talentGroup')
    end
  end
end
