require 'spec_helper'

module Wowr::Armory::Item
  describe EquipData do
    subject { EquipData.new(fake_element) }

    its(:inventory_type)  { should eql(18) }
    its(:subclass_name)   { should eql('Bag') }
    its(:container_slots) { should eql(22) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/49295.xml')
      (Hpricot.XML(xml)%'equipData')
    end
  end
end
