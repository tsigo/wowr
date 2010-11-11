require 'spec_helper'

module Wowr::Armory::Item
  describe Vendor do
    subject { Vendor.new(fake_element) }

    its(:id)             { should eql(18822) }
    its(:name)           { should eql('Quartermaster Davian Vaclav') }
    its(:title)          { should be_nil }
    its(:type)           { should eql('Humanoid') }
    its(:area)           { should eql('Nagrand') }
    its(:classification) { should eql(1) }
    its(:max_level)      { should eql(65) }
    its(:min_level)      { should eql(65) }

    # Alias methods
    its(:to_s) { should eql('Quartermaster Davian Vaclav') }
    its(:to_i) { should eql(18822) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/27644.xml')
      (Hpricot.XML(xml)%'vendors'/'creature')[0]
    end
  end
end
