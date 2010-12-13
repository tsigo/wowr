require 'spec_helper'

module Wowr::Armory::Character
  describe TalentSpec do
    subject { TalentSpec.new(fake_element) }

    its(:active)             { should_not be_nil }
    its(:group)              { should eql(2) }
    its(:primary)            { should eql("Beast Mastery") }
    its(:point_distribution) { should match(/^\d+$/) }
    its(:trees)              { should be_kind_of(Array) }

    describe "glyphs" do
      it "should return an Array of Glyphs" do
        subject.glyphs.should be_kind_of(Array)
        subject.glyphs[0].should be_kind_of(Wowr::Armory::Item::Glyph)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-talents/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'talentGroup')
    end
  end
end
