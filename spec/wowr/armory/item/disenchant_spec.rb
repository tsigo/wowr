require 'spec_helper'

module Wowr::Armory::Item
  describe Disenchant do
    subject { Disenchant.new(fake_element) }

    its(:level)      { should eql(80) }
    its(:type)       { should eql("Enchanting") }
    its(:drop_rate)  { should eql(6) }
    its(:min_count)  { should eql(1) }
    its(:max_count)  { should eql(1) }
    its(:quality)    { should eql(4) }

    # Inherited from Base
    its(:name)       { should eql("Abyss Crystal") }
    its(:icon_base)  { should eql("inv_enchant_abysscrystal") }
    its(:id)         { should eql(34057) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/40395.xml')
      (Hpricot.XML(xml)%'disenchantLoot'/'item')[0]
    end
  end
end
