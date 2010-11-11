require 'spec_helper'

module Wowr::Armory::Character::Spell
  describe Speed do
    subject { Speed.new(fake_element) }

    its(:haste_rating)     { should satisfy { |v| v > 0 && v < 5000 } }
    its(:percent_increase) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/fearsom_mal_ganis.xml')
      (Hpricot.XML(xml)%'spell'/'hasteRating')[0]
    end

  end
end
