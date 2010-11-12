require 'spec_helper'

module Wowr::Armory::Item
  describe Full do
    subject { Full.new(fake_info, fake_tooltip) }

    it "should delegate info methods to Info" do
      Info.any_instance.expects(:info_method).returns('')
      expect { subject.info_method }.to_not raise_error
    end

    it "should delegate tooltip methods to Tooltip" do
      Tooltip.any_instance.expects(:tooltip_method).returns('')
      expect { subject.tooltip_method }.to_not raise_error
    end

    it "should raise NoMethodError when given an invalid method" do
      expect { subject.foo }.to raise_error(NoMethodError)
    end

    protected

    def fake_info
      xml = file_fixture('armory/item-info/40395.xml')
      (Nokogiri::XML(xml)%'itemInfo')
    end

    def fake_tooltip
      xml = file_fixture('armory/item-tooltip/40395.xml')
      (Nokogiri::XML(xml)%'itemTooltip')
    end
  end
end
