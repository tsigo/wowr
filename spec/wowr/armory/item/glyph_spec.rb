require 'spec_helper'

module Wowr::Armory::Item
  describe Glyph do
    subject { Glyph.new(fake_element) }

    its(:id)     { should satisfy { |v| v > 0 } }
    its(:effect) { should_not be_nil }
    its(:type)   { satisfy { |v| %w(major minor prime).include? v } }

    its(:class) { should superclass(Base) }

    protected

    def fake_element
      xml = file_fixture('armory/character-talents/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml).search('glyphs/glyph').first)
    end
  end
end
