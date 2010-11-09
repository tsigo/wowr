require 'spec_helper'

module Wowr::Armory::Achievement
  describe List do
    subject { List.new(fake_element) }

    describe "achievements" do
      it "should be an Array of [Completed]Achievement records" do
        subject.achievements.should be_kind_of(Array)
        subject.achievements[0].should be_kind_of(Base)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis_c_168.xml')
      (Hpricot.XML(xml))
    end
  end
end
