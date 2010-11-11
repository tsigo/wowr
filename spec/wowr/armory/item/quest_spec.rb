require 'spec_helper'

module Wowr::Armory::Item
  describe Quest do
    subject { Quest.new(fake_element) }

    its(:name)                 { should eql("Battle at Valhalas: Final Challenge") }
    its(:id)                   { should eql(13219) }
    its(:level)                { should eql(80) }
    its(:min_level)            { should eql(77) }
    its(:area)                 { should eql("Icecrown") }
    its(:suggested_party_size) { should eql(5) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/44382.xml')
      (Hpricot.XML(xml)%'rewardFromQuests'/'quest')[0]
    end
  end
end
