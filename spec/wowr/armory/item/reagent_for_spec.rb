require 'spec_helper'

module Wowr::Armory::Item
  describe ReagentFor do
    subject { ReagentFor.new(fake_element) }

    its(:item) { should be_kind_of(Created) }

    describe "reagents" do
      it "should be an Array of Reagent instances" do
        subject.reagents.should be_kind_of(Array)
        subject.reagents[0].should be_kind_of(Reagent)
        subject.reagents.length.should eql(2)
      end
    end

    its(:class) { should superclass(Base) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/17204.xml')
      (Nokogiri::XML(xml)%'reagentFor/spell')
    end
  end
end
