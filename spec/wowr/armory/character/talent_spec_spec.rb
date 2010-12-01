require 'spec_helper'

module Wowr::Armory::Character
  describe TalentSpec do
    subject { TalentSpec.new(fake_element) }

    its(:active) { should be_true }
    its(:group) { should eql(2) }
    its(:primary) { should eql("Beast Mastery") }
    its(:point_distribution) { should match(/^\d+$/) }
    its(:trees) { should be_kind_of(Array) }

    describe "glyphs" do
      it "should return an Array of Glyphs" do
        subject.glyphs.should be_kind_of(Array)
        subject.glyphs[0].should be_kind_of(Glyph)
      end

      it "should return the expected values" do
        subject.glyphs[0].id.should eql(353)
        subject.glyphs[0].effect.should eql("Reduces the focus cost of Trap Launcher by 10.")
        subject.glyphs[0].name.should eql("Glyph of Trap Launcher")
        subject.glyphs[0].type.should eql("major")
        subject.glyphs[0].icon.should eql("ability_hunter_traplauncher")
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-talents/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'talentGroup')
    end
  end
end
