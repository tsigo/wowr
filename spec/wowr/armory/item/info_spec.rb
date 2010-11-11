require 'spec_helper'

module Wowr::Armory::Item
  describe Info, "40395 - Torch of Holy Fire" do
    subject { Info.new(fake_element) }

    its(:level)   { should eql(226) }
    its(:quality) { should eql(4) }
    its(:type)    { should eql("One-Handed Maces") }
    its(:cost)    { should be_kind_of(Cost) }

    describe "disenchant_items" do
      it "should be an Array of Disenchant instances" do
        subject.disenchant_items.should be_kind_of(Array)
        subject.disenchant_items[0].should be_kind_of(Disenchant)
      end
    end

    its(:disenchant_skill_rank) { should eql(375) }

    describe "drop_creatures" do
      it "should be an Array of DropCreature instances" do
        subject.drop_creatures.should be_kind_of(Array)
        subject.drop_creatures[0].should be_kind_of(DropCreature)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/item-info/40395.xml')
      (Hpricot.XML(xml)%'item')
    end
  end

  describe Info, "49623 - Shadowmourne" do
    subject { Info.new(fake_element) }

    describe "reward_from_quests" do
      it "should be an Array of Quest instances" do
        subject.reward_from_quests.should be_kind_of(Array)
        subject.reward_from_quests[0].should be_kind_of(Quest)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/item-info/49623.xml')
      (Hpricot.XML(xml)%'item')
    end
  end

  describe Info, "44434 - Dark Matter" do
    subject { Info.new(fake_element) }

    describe "objective_of_quests" do
      it "should be an Array of Quest instances" do
        subject.objective_of_quests.should be_kind_of(Array)
        subject.objective_of_quests[0].should be_kind_of(Quest)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/item-info/44434.xml')
      (Hpricot.XML(xml)%'item')
    end
  end

  # TODO: Test the following elements:
  # * plansFor/spell
end
