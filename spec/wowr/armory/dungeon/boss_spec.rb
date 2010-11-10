require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Boss do
    subject { Boss.new(fake_element) }

    its(:id)    { should eql(10184) }
    its(:key)   { should eql('onyxia') }

    its(:name)  { pending } # { should eql('Onyxia') }

    its(:to_s)  { pending } # :name
    its(:to_i)  { should eql(10184) }

    protected

    def fake_element
      xml = file_fixture('armory/dungeons/dungeons.xml')
      (Hpricot.XML(xml).search("boss[@key='onyxia']").first)
    end
  end
end
