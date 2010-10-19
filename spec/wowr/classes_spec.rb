require 'spec_helper'

module Wowr::Classes

  # Achievements
  # PENDING

  # Arena Team
  describe ArenaTeam do
    it "should subclass Wowr::Armory::ArenaTeam::Base" do
      ArenaTeam.superclass.should equal(Wowr::Armory::ArenaTeam::Base)
    end
  end

  describe SearchArenaTeam do
    it "should subclass Wowr::Armory::ArenaTeam::Search" do
      SearchArenaTeam.superclass.should equal(Wowr::Armory::ArenaTeam::Search)
    end
  end

  describe FullArenaTeam do
    it "should subclass Wowr::Armory::ArenaTeam::Full" do
      FullArenaTeam.superclass.should equal(Wowr::Armory::ArenaTeam::Full)
    end
  end

  describe ArenaTeamEmblem do
    it "should subclass Wowr::Armory::ArenaTeam::Emblem" do
      ArenaTeamEmblem.superclass.should equal(Wowr::Armory::ArenaTeam::Emblem)
    end
  end

  # Calendar
  # PENDING

  # Character
  # PENDING

  # Dungeon
  # PENDING

  # Guild
  describe Guild do
    it "should subclass Wowr::Armory::Guild::Base" do
      Guild.superclass.should equal(Wowr::Armory::Guild::Base)
    end
  end

  describe SearchGuild do
    it "should subclass Wowr::Armory::Guild::Search" do
      SearchGuild.superclass.should equal(Wowr::Armory::Guild::Search)
    end
  end

  describe FullGuild do
    it "should subclass Wowr::Armory::Guild::Full" do
      FullGuild.superclass.should equal(Wowr::Armory::Guild::Full)
    end
  end

  # Guild Bank
  describe GuildBank do
    it "should subclass Wowr::Armory::GuildBank::Base" do
      GuildBank.superclass.should equal(Wowr::Armory::GuildBank::Base)
    end
  end

  describe GuildBankContents do
    it "should subclass Wowr::Armory::GuildBank::Contents" do
      GuildBankContents.superclass.should equal(Wowr::Armory::GuildBank::Contents)
    end
  end

  describe GuildBankLog do
    it "should subclass Wowr::Armory::GuildBank::Log" do
      GuildBankLog.superclass.should equal(Wowr::Armory::GuildBank::Log)
    end
  end

  describe GuildBankBag do
    it "should subclass Wowr::Armory::GuildBank::Bag" do
      GuildBankBag.superclass.should equal(Wowr::Armory::GuildBank::Bag)
    end
  end

  describe GuildBankLogEntry do
    it "should subclass Wowr::Armory::GuildBank::LogEntry" do
      GuildBankLogEntry.superclass.should equal(Wowr::Armory::GuildBank::LogEntry)
    end
  end

  describe GuildBankLogItem do
    it "should subclass Wowr::Armory::GuildBank::LogItem" do
      GuildBankLogItem.superclass.should equal(Wowr::Armory::GuildBank::LogItem)
    end
  end

  describe GuildBankItem do
    it "should subclass Wowr::Armory::GuildBank::Item" do
      GuildBankItem.superclass.should equal(Wowr::Armory::GuildBank::Item)
    end
  end

  # Item
  describe Item do
    it "should subclass Wowr::Armory::Item::Base" do
      Item.superclass.should equal(Wowr::Armory::Item::Base)
    end
  end

  describe FullItem do
    it "should subclass Wowr::Armory::Item::Full" do
      FullItem.superclass.should equal(Wowr::Armory::Item::Full)
    end
  end

  describe ItemInfo do
    it "should subclass Wowr::Armory::Item::Info" do
      ItemInfo.superclass.should equal(Wowr::Armory::Item::Info)
    end
  end

  describe ItemTooltip do
    it "should subclass Wowr::Armory::Item::Tooltip" do
      ItemTooltip.superclass.should equal(Wowr::Armory::Item::Tooltip)
    end
  end

  describe SearchItem do
    it "should subclass Wowr::Armory::Item::Search" do
      SearchItem.superclass.should equal(Wowr::Armory::Item::Search)
    end
  end

  describe DisenchantItem do
    it "should subclass Wowr::Armory::Item::Disenchant" do
      DisenchantItem.superclass.should equal(Wowr::Armory::Item::Disenchant)
    end
  end

  describe CreatedItem do
    it "should subclass Wowr::Armory::Item::Created" do
      CreatedItem.superclass.should equal(Wowr::Armory::Item::Created)
    end
  end

  describe PlanItem do
    it "should subclass Wowr::Armory::Item::Plan" do
      PlanItem.superclass.should equal(Wowr::Armory::Item::Plan)
    end
  end

  describe Reagent do
    it "should subclass Wowr::Armory::Item::Reagent" do
      Reagent.superclass.should equal(Wowr::Armory::Item::Reagent)
    end
  end

  describe ItemEquipData do
    it "should subclass Wowr::Armory::Item::EquipData" do
      ItemEquipData.superclass.should equal(Wowr::Armory::Item::EquipData)
    end
  end

  describe ItemSetData do
    it "should subclass Wowr::Armory::Item::SetData" do
      ItemSetData.superclass.should equal(Wowr::Armory::Item::SetData)
    end
  end

  describe ItemSetBonus do
    it "should subclass Wowr::Armory::Item::SetBonus" do
      ItemSetBonus.superclass.should equal(Wowr::Armory::Item::SetBonus)
    end
  end

  describe ItemSpell do
    it "should subclass Wowr::Armory::Item::Spell" do
      ItemSpell.superclass.should equal(Wowr::Armory::Item::Spell)
    end
  end

  describe ItemDamageData do
    it "should subclass Wowr::Armory::Item::DamageData" do
      ItemDamageData.superclass.should equal(Wowr::Armory::Item::DamageData)
    end
  end

  describe ItemSource do
    it "should subclass Wowr::Armory::Item::Source" do
      ItemSource.superclass.should equal(Wowr::Armory::Item::Source)
    end
  end

  describe ItemQuest do
    it "should subclass Wowr::Armory::Item::Quest" do
      ItemQuest.superclass.should equal(Wowr::Armory::Item::Quest)
    end
  end

  describe ItemDropCreature do
    it "should subclass Wowr::Armory::Item::DropCreature" do
      ItemDropCreature.superclass.should equal(Wowr::Armory::Item::DropCreature)
    end
  end

  describe ItemCost do
    it "should subclass Wowr::Armory::Item::Cost" do
      ItemCost.superclass.should equal(Wowr::Armory::Item::Cost)
    end
  end

  describe ItemCostToken do
    it "should subclass Wowr::Armory::Item::CostToken" do
      ItemCostToken.superclass.should equal(Wowr::Armory::Item::CostToken)
    end
  end

  describe ItemVendor do
    it "should subclass Wowr::Armory::Item::Vendor" do
      ItemVendor.superclass.should equal(Wowr::Armory::Item::Vendor)
    end
  end

  describe ItemCreation do
    it "should subclass Wowr::Armory::Item::Creation" do
      ItemCreation.superclass.should equal(Wowr::Armory::Item::Creation)
    end
  end

  describe ItemPlansFor do
    it "should subclass Wowr::Armory::Item::PlansFor" do
      ItemPlansFor.superclass.should equal(Wowr::Armory::Item::PlansFor)
    end
  end

  describe ItemCreatedBy do
    it "should subclass Wowr::Armory::Item::CreatedBy" do
      ItemCreatedBy.superclass.should equal(Wowr::Armory::Item::CreatedBy)
    end
  end

end
