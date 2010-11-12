require 'spec_helper'

module Wowr::Armory::Item
  describe DamageData do
    subject { DamageData.new(fake_element) }

    its(:type)  { should eql(0) }
    its(:min)   { should eql(886) }
    its(:max)   { should eql(1329) }
    its(:speed) { should eql(3.4) }
    its(:dps)   { should eql(325.74) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/50727.xml')
      (Nokogiri::XML(xml)%'damageData')
    end
  end
end
