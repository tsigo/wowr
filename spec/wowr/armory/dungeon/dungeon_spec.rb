require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Dungeon do
    subject { Dungeon.new(fake_element) }

    its(:id)            { should eql(2159) }
    its(:key)           { should eql('onyxiaslair') }
    its(:level_minimum) { should eql(80) }
    its(:level_maximum) { should eql(80) }
    its(:party_size)    { should eql(25) }
    its(:raid)          { should be_true }
    its(:release)       { should eql(2) }
    its(:heroic)        { should be_true }
    its(:to_i)          { should eql(2159) }
    its(:max_level)     { should eql(80) }
    its(:min_level)     { should eql(80) }

    describe "add_name_data" do
      let(:name_data) { fake_name_data }

      it "should assign to name" do
        expect { subject.add_name_data(name_data) }.to change(subject, :name).to("Onyxia's Lair")
      end

      it "should assign to bosses" do
        subject.add_name_data(name_data)
        subject.bosses.size.should eql(1)
        subject.bosses[10184].should be_kind_of(Boss)
        subject.bosses['onyxia'].should equal(subject.bosses[10184])
      end

      it "should return the subject's name as a string" do
        subject.add_name_data(name_data)
        subject.to_s.should eql("Onyxia's Lair")
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/dungeons/dungeons.xml')
      (Nokogiri::XML(xml).search("dungeon[@key='onyxiaslair']").first)
    end

    def fake_name_data
      xml = file_fixture('armory/dungeons/dungeonStrings.xml')
      (Nokogiri::XML(xml).search("dungeon[@key='onyxiaslair']").first)
    end
  end
end
