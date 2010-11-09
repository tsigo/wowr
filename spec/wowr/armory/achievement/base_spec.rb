require 'spec_helper'

module Wowr::Armory::Achievement
  describe Base, "with points" do
    subject { Base.new(fake_element) }

    its(:desc)        { should eql("Complete the 25-player raid achievements listed below.") }
    its(:category_id) { should eql(168) }
    its(:icon)        { should eql('inv_helmet_151') }
    its(:id)          { should eql(4603) }
    its(:points)      { should eql(25) }
    its(:reward)      { should eql("Reward: Icebound Frostbrood Vanquisher") }
    its(:title)       { should eql("Glory of the Icecrown Raider (25 player)") }

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis_c_168.xml')
      (Hpricot.XML(xml).search("achievement[@id=4603]").first)
    end
  end

  describe Base, "without points" do
    subject { Base.new(fake_element) }

    its(:points) { should eql(0) }
    its(:reward) { should eql("Reward: Crusader's Black Warhorse") }

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis_c_81.xml')
      (Hpricot.XML(xml).search("achievement[@id=4079]").first)
    end
  end
end
