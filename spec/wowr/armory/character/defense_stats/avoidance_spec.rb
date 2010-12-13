require 'spec_helper'

module Wowr::Armory::Character::DefenseStats
  describe Avoidance, "dodge" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should be_percentage }
    its(:increase_percent) { should be_percentage }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Nokogiri::XML(xml)%'defenses'%'dodge')
    end
  end

  describe Avoidance, "parry" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should be_percentage }
    its(:increase_percent) { should be_percentage }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 1000 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Nokogiri::XML(xml)%'defenses'%'parry')
    end
  end

  describe Avoidance, "block" do
    subject { Avoidance.new(fake_element) }

    its(:percent)          { should be_percentage }
    its(:increase_percent) { should be_percentage }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Nokogiri::XML(xml)%'defenses'%'block')
    end
  end
end
