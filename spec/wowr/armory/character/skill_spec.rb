require 'spec_helper'

module Wowr::Armory::Character
  describe Skill do
    subject { Skill.new(fake_element) }

    its(:key)   { should eql('firstaid') }
    its(:name)  { should eql('First Aid') }
    its(:value) { should eql(450) }
    its(:max)   { should eql(450) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml).search("skill[@id=129]").first)
    end
  end
end
