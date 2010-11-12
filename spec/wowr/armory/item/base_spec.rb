require 'spec_helper'

module Wowr::Armory::Item
  describe Base, "attributes" do
    subject { Base.new(fake_element) }

    its(:id)        { should eql(40395) }
    its(:name)      { should eql("Torch of Holy Fire") }
    its(:icon_base) { should eql("inv_mace_82") }

    # Alias methods
    its(:item_id) { should eql(40395) }
    its(:to_s)    { should eql("Torch of Holy Fire") }
    its(:to_i)    { should eql(40395) }

    protected

    def fake_element
      xml = file_fixture('armory/item-info/40395.xml')
      (Nokogiri::XML(xml)%'itemInfo'/'item')[0]
    end
  end

  describe Base, "#icon" do
    let(:api) { Wowr::API.new }

    it "should raise InvalidIconSize when given an invalid size" do
      expect { Base.new(fake_element).icon(:gargantuan) }.to raise_error(Wowr::Exceptions::InvalidIconSize)
    end

    it "should use API's base_url when initialized with an API instance" do
      api.expects(:base_url).returns('')
      Base.new(fake_element, api).icon
    end

    it "should use a default base_url when initialized without an API instance" do
      Base.new(fake_element).icon.should match(%r{www\.wowarmory\.com/})
    end

    it "should use a special icon_url_base for Taiwan" do
      api.expects(:locale).returns('tw')
      Base.new(fake_element, api).icon.should match(%r{wow-icons/_images/})
    end

    it "should use the default icon_url_base outside of Taiwan" do
      Base.new(fake_element).icon.should match(%r{wow-icons/_images/})
    end

    it "should take a custom icon size" do
      Base.new(fake_element).icon(:small).should match(%r{21x21/inv_mace_82.png})
    end

    protected

    def fake_element
      xml = file_fixture('armory/item-info/40395.xml')
      (Nokogiri::XML(xml)%'itemInfo'/'item')[0]
    end
  end
end
