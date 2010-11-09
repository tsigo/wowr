require 'spec_helper'

module Wowr::Armory::Achievement
  describe CharacterInfo do
    subject { CharacterInfo.new(fake_element) }

    describe "latest_achievements" do
      it "should return an array of Completed instances" do
        subject.latest_achievements.should be_kind_of(Array)
        subject.latest_achievements[0].should be_kind_of(Completed)
      end
    end

    describe "categories" do
      it "should return an array of CategoryDetailsWithPoints" do
        subject.categories.should be_kind_of(Array)
        subject.categories[0].should be_kind_of(CategoryDetailsWithPoints)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'page')
    end
  end
end
