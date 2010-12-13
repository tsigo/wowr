require 'spec_helper'

module Wowr::Armory::Character
  describe Skill do
    subject { Skill.new(fake_element) }

    its(:key)   { should eql('trade_leatherworking') }
    its(:name)  { should eql('Leatherworking') }
    its(:value) { should eql(525) }
    its(:max)   { should eql(525) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml).search("skill[@id='165']").first)
    end
  end
end
