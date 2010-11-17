require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Boss do
    subject { Boss.new(fake_element) }

    its(:id)    { should eql(10184) }
    its(:key)   { should eql('onyxia') }
    its(:to_i)  { should eql(10184) }

    it "should have a name accessor" do
      expect { subject.name = 'Foo' }.to change(subject, :name).from(nil).to('Foo')
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
