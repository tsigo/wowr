require 'spec_helper'

module Wowr::Armory::Item
  describe Tooltip, "40395 - Torch of Holy Fire" do
    subject { Tooltip.new(fake_element) }

    its(:id)                 { should eql(40395) }
    its(:name)               { should eql("Torch of Holy Fire") }
    its(:icon_base)          { should eql("inv_mace_82") }
    its(:desc)               { should be_nil }
    its(:overall_quality_id) { should eql(4) }
    its(:bonding)            { should eql(1) }
    # its(:stackable)        { should be_nil } # FIXME: No attr_reader defined; intentional? (tsigo)
    its(:max_count)          { should be_nil }
    its(:class_id)           { should eql(2) }
    its(:required_level)     { should eql(80) }

    its(:equip_data)         { should be_an(EquipData) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:damage) { should be_a(DamageData) }

    its(:gem_properties) { should be_nil }

    its(:sockets) { should be_nil }

    its(:bonuses) { should include(:stamina => 82) }
    its(:bonuses) { should include(:spirit => 38) }
    its(:bonuses) { should include(:haste => 48) }
    its(:bonuses) { should include(:spell_power => 651) }

    its(:resistances) { should eql({}) }

    its(:allowable_classes) { should be_nil }

    its(:armor) { should be_nil }

    its(:durability) { should eql(105) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:spells) { should be_nil }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:set_data) { should be_nil }

    its(:item_source) { should be_a(Source) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/40395.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end

  describe Tooltip, "46017 - Val'anyr, Hammer of Ancient Kings" do
    subject { Tooltip.new(fake_element) }

    its(:desc)               { should eql("The power of creation courses through this weapon.") }
    its(:overall_quality_id) { should eql(5) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:damage) { should be_a(DamageData) }

    its(:bonuses) { should include(:stamina => 105) }
    its(:bonuses) { should include(:crit => 50) }
    its(:bonuses) { should include(:haste => 49) }
    its(:bonuses) { should include(:spell_power => 777) }

    its(:durability) { should eql(125) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:spells) { should be_nil }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:set_data) { should be_nil }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/46017.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end

  describe Tooltip, "16922 - Leggings of Transcendence" do
    subject { Tooltip.new(fake_element) }

    its(:class_id) { should eql(4) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:damage) { should be_a(DamageData) }

    its(:bonuses) { should include(:spirit => 29) }
    its(:bonuses) { should include(:stamina => 36) }
    its(:bonuses) { should include(:intellect => 21) }

    its(:allowable_classes) { should eql(['Priest']) }

    its(:armor) { should eql(221) }

    its(:durability) { should eql(120) }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:spells) { should be_nil }

    # FIXME: No attr_reader defined; intentional? (tsigo)
    # its(:set_data) { should be_nil }

    its(:item_source) { should be_a(Source) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/16922.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end

  describe Tooltip, "50727 - Bloodfall" do
    subject { Tooltip.new(fake_element) }

    its(:sockets) { should include('Red') }
    its(:sockets) { should include('Yellow') }
    its(:sockets) { should include('Blue') }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/50727.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end

  describe Tooltip, "40111 - Bold Cardinal Ruby" do
    subject { Tooltip.new(fake_element) }

    its(:gem_properties) { should eql("+20 Strength") }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/40111.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end

  # TODO: Find and spec items with the following attributes:
  # * stackable
  # * max_count
  # * resistances (Could not find a single item on Armory that had this data, even items that Wowhead confirms to have resistances)
  # * socket_match_enchant (Armory doesn't seem to have this data anymore)
end
