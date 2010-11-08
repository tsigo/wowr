require 'spec_helper'

module Wowr::Armory::Character
  describe Pvp do
    subject { Pvp.new(fake_element) }

    its(:lifetime_honorable_kills) { should satisfy { |v| v > 0 } }
    its(:arena_currency)           { should eql(0) }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml)%'pvp')
    end
  end
end
