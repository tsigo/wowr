require 'spec_helper'

module Wowr::Armory::Character::DefenseStats
  describe Avoidance, "dodge" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:increase_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'dodge')
    end
  end

  describe Avoidance, "parry" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:increase_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'parry')
    end
  end

  describe Avoidance, "block" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:increase_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'block')
    end
  end
end
