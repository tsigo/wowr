require 'spec_helper'

module Wowr::Armory::Item
  describe Plan do
    subject { Plan.new(fake_element) }

    its(:required_skill)      { should eql("Blacksmithing") }
    its(:type)                { should eql("Blacksmithing") }
    its(:required_skill_rank) { should eql(450) }
    its(:level)               { should eql(85) }
    its(:quality)             { should eql(4) }

    # Inherited from Base
    its(:id)        { should eql(45089) }
    its(:name)      { should eql("Plans: Battlelord's Plate Boots") }
    its(:icon_base) { should eql("inv_scroll_04") }

    protected

    def fake_element
      xml = <<-XML
      <item canAuction="1" icon="inv_scroll_04" id="45089" level="85" name="Plans: Battlelord's Plate Boots" quality="4" requiredSkill="Blacksmithing" requiredSkillRank="450" type="Blacksmithing">
      XML

      (Hpricot.XML(xml)%'item')
    end
  end
end
