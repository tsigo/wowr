require 'spec_helper'

module Wowr::Armory::Item
  describe Reagent do
    subject { Reagent.new(fake_element) }

    its(:count) { should eql(40) }

    # Inherited from Base
    its(:id)        { should eql(38558) }
    its(:name)      { should eql("Nerubian Chitin") }
    its(:icon_base) { should eql("inv_misc_nerubianchitin_01") }

    protected

    def fake_element
      # http://www.wowarmory.com/item-info.xml?i=47579
      xml = <<-XML
      <createdBy>
        <spell icon="trade_leatherworking" id="67081" name="Black Chitin Bracers">
          <reagent count="40" icon="inv_misc_nerubianchitin_01" id="38558" name="Nerubian Chitin" quality="1"/>
          <reagent count="4" icon="inv_enchant_abysscrystal" id="34057" name="Abyss Crystal" quality="4"/>
          <reagent count="6" icon="inv_misc_pelt_14" id="44128" name="Arctic Fur" quality="3"/>
          <reagent count="4" icon="spell_holy_rune" id="47556" name="Crusader Orb" quality="3"/>
        </spell>
      </createdBy>
      XML

      (Hpricot.XML(xml)%'spell'/'reagent')[0]
    end
  end
end
