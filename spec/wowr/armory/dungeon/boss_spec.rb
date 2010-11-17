require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Boss do
    subject { Boss.new(fake_element) }

    its(:id)    { should eql(10184) }
    its(:key)   { should eql('onyxia') }
    its(:to_i)  { should eql(10184) }

    describe "add_name_data" do
      let(:sub) { fake_boss_element }

      it "should assign to name" do
        expect { subject.add_name_data(sub) }.to change(subject, :name).to('Onyxia')
      end

      it "should return the boss's name as a string" do
        subject.add_name_data(sub)
        subject.to_s.should eql('Onyxia')
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/dungeons/dungeons.xml')
      (Nokogiri::XML(xml).search("boss[@key='onyxia']").first)
    end

    def fake_boss_element
      xml = file_fixture('armory/dungeons/dungeonStrings.xml')
      (Nokogiri::XML(xml).search("boss[@name='Onyxia']").first)
    end
  end
end
