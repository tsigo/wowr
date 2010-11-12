require 'spec_helper'

module Wowr::Armory::Achievement
  describe CategoryDetails do
    subject { CategoryDetails.new(fake_element) }

    its(:earned) { should eql(20) }

    its(:class) { should superclass(Category) }

    protected

    def fake_element
      # NOTE: CategoryDetails actually expects a Hash, and not an Nokogiri::XML::Element instance
      {:name => '', :id => 0, :earned => "20"}

      # xml = file_fixture('armory/character-achievements/sebudai_mal_ganis.xml')
      # (Nokogiri::XML(xml).search('category/c:not([total])').first)
    end
  end
end
