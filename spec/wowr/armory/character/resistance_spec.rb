require 'spec_helper'

module Wowr::Armory::Character
  describe Resistance do
    subject { Resistance.new(fake_element) }

    its(:value)     { should satisfy { |v| v >= 100 } }
    its(:pet_bonus) { should satisfy { |v| v >= 200 } }

    protected

    def fake_element
      # NOTE: It's hard to catch anyone on the Armory in resistance gear, so
      # we're going to fake it by using a hash, just this once. But we're still
      # using a fixture to catch any changes to the Armory attributes.

      xml = file_fixture('armory/character-sheet/sebudai_mal_ganis.xml')
      elem = (Nokogiri::XML(xml)%'resistances'/'shadow')[0]

      elem[:value].should_not be_nil
      elem[:petBonus].should_not be_nil

      {:value => (elem[:value].to_i + 100).to_s, :petBonus => (elem[:petBonus].to_i + 200).to_s}
    end

  end
end
