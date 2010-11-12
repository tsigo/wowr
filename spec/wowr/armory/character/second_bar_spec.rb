require 'spec_helper'

module Wowr::Armory::Character
  describe SecondBar do
    subject { SecondBar.new(fake_element) }

    its(:effective)   { should satisfy { |v| v > 10000 && v < 80000 } }
    its(:casting)     { should satisfy { |v| v > 0 && v < 2000 } }
    its(:not_casting) { should satisfy { |v| v > 0 && v < 2000 } }
    its(:type)        { should eql('m') }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Nokogiri::XML(xml)%'secondBar')
    end
  end
end
