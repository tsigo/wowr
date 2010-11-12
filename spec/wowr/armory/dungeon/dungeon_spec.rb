require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Dungeon do
    subject { Dungeon.new(fake_element) }

    its(:id)            { should eql(2159) }
    its(:key)           { should eql('onyxiaslair') }

    its(:name)          { pending } # { should eql('Onyxia\'s Lair') }

    its(:level_minimum) { should eql(80) }
    its(:level_maximum) { should eql(80) }
    its(:party_size)    { should eql(25) }
    its(:raid)          { should be_true }
    its(:release)       { should eql(2) }
    its(:heroic)        { should be_true }

    its(:bosses)        { pending } # { Bosses }

    its(:to_s)          { pending } # :name
    its(:to_i)          { should eql(2159) }
    its(:max_level)     { should eql(80) }
    its(:min_level)     { should eql(80) }

    protected

    def fake_element
      xml = file_fixture('armory/dungeons/dungeons.xml')
      (Nokogiri::XML(xml).search("dungeon[@key='onyxiaslair']").first)
    end
  end
end
