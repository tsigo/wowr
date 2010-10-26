require 'spec_helper'

module Wowr::Armory::Item
  describe Spell do
    subject { Spell.new(fake_element) }
    let(:expected_desc) { "Teaches you how to summon this mount.  This is a very fast mount." }

    its(:trigger)     { should eql(6) }
    its(:description) { should eql(expected_desc) }

    # Alias methods
    its(:desc) { should eql(expected_desc) }
    its(:to_s) { should eql(expected_desc) }

    protected

    def fake_element
      xml = <<-XML
      <spellData>
        <spell>
          <trigger>6</trigger>
          <desc>Teaches you how to summon this mount.  This is a very fast mount.</desc>
        </spell>
      </spellData>
      XML

      (Hpricot.XML(xml)%'spellData'/'spell')[0]
    end
  end
end
