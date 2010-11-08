require 'spec_helper'

module Wowr::Armory::Character::Defenses
  describe DodgeParryBlock, "dodge" do
    subject { DodgeParryBlock.new(fake_element) }

    its(:percent)          { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:increase_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'dodge')
    end
  end

  describe DodgeParryBlock, "parry" do
    subject { DodgeParryBlock.new(fake_element) }

    its(:percent)          { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:increase_percent) { should satisfy { |v| v >= 0.00 && v <= 100.00 } }
    its(:rating)           { should satisfy { |v| v >= 0 && v <= 100 } }

    protected

    def fake_element
      xml = file_fixture('armory/character-sheet/alephone_mal_ganis.xml')
      (Hpricot.XML(xml)%'defenses'%'parry')
    end
  end

  describe DodgeParryBlock, "block" do
    subject { DodgeParryBlock.new(fake_element) }

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
