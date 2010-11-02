require 'spec_helper'

module Wowr::Armory::Item
  describe EquipData do
    subject { EquipData.new(fake_element) }

    its(:inventory_type)  { should eql(18) }
    its(:subclass_name)   { should eql('Bag') }
    its(:container_slots) { should eql(22) }

    protected

    def fake_element
      # http://www.wowarmory.com/item-tooltip.xml?i=49295
      xml = <<-XML
      <equipData>
        <inventoryType>18</inventoryType>
        <containerSlots>22</containerSlots>
        <subclassName>Bag</subclassName>
      </equipData>
      XML

      (Hpricot.XML(xml)%'equipData')
    end
  end
end
