require 'spec_helper'

module Wowr::Armory::Item
  describe SetBonus do
    subject { SetBonus.new(fake_element) }
    let(:expected_desc) { "Increases the damage done by your Devouring Plague by 15%." }

    its(:threshold)   { should eql(2) }
    its(:description) { should eql(expected_desc) }

    # Alias methods
    its(:desc) { should eql(expected_desc) }
    its(:to_s) { should eql(expected_desc) }

    protected

    def fake_element
      xml = file_fixture('armory/item-tooltip/46163.xml')
      (Hpricot.XML(xml)%'setData'/'setBonus')[0]
    end
  end
end
