require 'spec_helper'

module Wowr::Classes

  # Achievements
  describe CharacterAchievementsInfo do
    it "should subclass Wowr::Armory::Achievement::CharacterInfo" do
      CharacterAchievementsInfo.superclass.should equal(Wowr::Armory::Achievement::CharacterInfo)
    end
  end

  describe Achievement do
    it "should subclass Wowr::Armory::Achievement::Base" do
      Achievement.superclass.should equal(Wowr::Armory::Achievement::Base)
    end
  end

  describe CompletedAchievement do
    it "should subclass Wowr::Armory::Achievement::Completed" do
      CompletedAchievement.superclass.should equal(Wowr::Armory::Achievement::Completed)
    end
  end

  describe AchievementsCategory do
    it "should subclass Wowr::Armory::Achievement::Category" do
      AchievementsCategory.superclass.should equal(Wowr::Armory::Achievement::Category)
    end
  end

  describe AchievementsCategoryDetails do
    it "should subclass Wowr::Armory::Achievement::CategoryDetail" do
      AchievementsCategoryDetails.superclass.should equal(Wowr::Armory::Achievement::CategoryDetail)
    end
  end

  describe AchievementsCategoryDetailsWithPoints do
    it "should subclass Wowr::Armory::Achievement::CategoryDetailWithPoints" do
      AchievementsCategoryDetailsWithPoints.superclass.should equal(Wowr::Armory::Achievement::CategoryDetailWithPoints)
    end
  end

  describe AchievementsList do
    it "should subclass Wowr::Armory::Achievement::List" do
      AchievementsList.superclass.should equal(Wowr::Armory::Achievement::List)
    end
  end

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
  describe Character do
    it "should subclass Wowr::Armory::Character::Base" do
      Character.superclass.should equal(Wowr::Armory::Character::Base)
    end
  end

  describe SearchCharacter do
    it "should subclass Wowr::Armory::Character::Base" do
      SearchCharacter.superclass.should equal(Wowr::Armory::Character::Base)
    end
  end

  describe InfoCharacter do
    it "should subclass Wowr::Armory::Character::Info" do
      InfoCharacter.superclass.should equal(Wowr::Armory::Character::Info)
    end
  end

  describe FullCharacter do
    it "should subclass Wowr::Armory::Character::Full" do
      FullCharacter.superclass.should equal(Wowr::Armory::Character::Full)
    end
  end

  describe SecondBar do
    it "should subclass Wowr::Armory::Character::SecondBar;" do
      SecondBar.superclass.should equal(Wowr::Armory::Character::SecondBar)
    end
  end

  describe BaseStat do
    it "should subclass Wowr::Armory::Character::Stat::Base;" do
      BaseStat.superclass.should equal(Wowr::Armory::Character::Stat::Base)
    end
  end

  describe Strength do
    it "should subclass Wowr::Armory::Character::Stat::Strength;" do
      Strength.superclass.should equal(Wowr::Armory::Character::Stat::Strength)
    end
  end

  describe Agility do
    it "should subclass Wowr::Armory::Character::Stat::Agility" do
      Agility.superclass.should equal(Wowr::Armory::Character::Stat::Agility)
    end
  end

  describe Stamina do
    it "should subclass Wowr::Armory::Character::Stat::Stamina" do
      Stamina.superclass.should equal(Wowr::Armory::Character::Stat::Stamina)
    end
  end

  describe Intellect do
    it "should subclass Wowr::Armory::Character::Stat::Intellect;" do
      Intellect.superclass.should equal(Wowr::Armory::Character::Stat::Intellect)
    end
  end

  describe Spirit do
    it "should subclass Wowr::Armory::Character::Stat::Spirit" do
      Spirit.superclass.should equal(Wowr::Armory::Character::Stat::Spirit)
    end
  end

  describe Armor do
    it "should subclass Wowr::Armory::Character::Stat::Armor" do
      Armor.superclass.should equal(Wowr::Armory::Character::Stat::Armor)
    end
  end

  describe Melee do
    it "should subclass Wowr::Armory::Character::Weapon::Melee" do
      Melee.superclass.should equal(Wowr::Armory::Character::Weapon::Melee)
    end
  end

  describe Ranged do
    it "should subclass Wowr::Armory::Character::Weapon::Ranged" do
      Ranged.superclass.should equal(Wowr::Armory::Character::Weapon::Ranged)
    end
  end

  describe WeaponSkill do
    it "should subclass Wowr::Armory::Character::Weapon::Skill" do
      WeaponSkill.superclass.should equal(Wowr::Armory::Character::Weapon::Skill)
    end
  end

  describe WeaponDamage do
    it "should subclass Wowr::Armory::Character::Weapon::Damage" do
      WeaponDamage.superclass.should equal(Wowr::Armory::Character::Weapon::Damage)
    end
  end

  describe WeaponSpeed do
    it "should subclass Wowr::Armory::Character::Weapon::Speed" do
      WeaponSpeed.superclass.should equal(Wowr::Armory::Character::Weapon::Speed)
    end
  end

  describe WeaponPower do
    it "should subclass Wowr::Armory::Character::Weapon::Power" do
      WeaponPower.superclass.should equal(Wowr::Armory::Character::Weapon::Power)
    end
  end

  describe WeaponHitRating do
    it "should subclass Wowr::Armory::Character::Weapon::HitRating" do
      WeaponHitRating.superclass.should equal(Wowr::Armory::Character::Weapon::HitRating)
    end
  end

  describe WeaponCritChance do
    it "should subclass Wowr::Armory::Character::Weapon::CritChance" do
      WeaponCritChance.superclass.should equal(Wowr::Armory::Character::Weapon::CritChance)
    end
  end

  describe WeaponExpertise do
    it "should subclass Wowr::Armory::Character::Weapon::Expertise" do
      WeaponExpertise.superclass.should equal(Wowr::Armory::Character::Weapon::Expertise)
    end
  end

  describe Spell do
    it "should subclass Wowr::Armory::Character::Spell::Spell" do
      Spell.superclass.should equal(Wowr::Armory::Character::Spell::Spell)
    end
  end

  describe SpellSpeed do
    it "should subclass Wowr::Armory::Character::Spell::Speed" do
      SpellSpeed.superclass.should equal(Wowr::Armory::Character::Spell::Speed)
    end
  end

  describe SpellDamage do
    it "should subclass Wowr::Armory::Character::Spell::Damage" do
      SpellDamage.superclass.should equal(Wowr::Armory::Character::Spell::Damage)
    end
  end

  describe ManaRegen do
    it "should subclass Wowr::Armory::Character::Spell::ManaRegen" do
      ManaRegen.superclass.should equal(Wowr::Armory::Character::Spell::ManaRegen)
    end
  end

  describe PetBonus do
    it "should subclass Wowr::Armory::Character::Weapon::PetBonus" do
      PetBonus.superclass.should equal(Wowr::Armory::Character::Weapon::PetBonus)
    end
  end

  describe Defenses do
    it "should subclass Wowr::Armory::Character::Stat::Defenses" do
      Defenses.superclass.should equal(Wowr::Armory::Character::Stat::Defenses)
    end
  end

  describe Defense do
    it "should subclass Wowr::Armory::Character::Stat::Defense" do
      Defense.superclass.should equal(Wowr::Armory::Character::Stat::Defense)
    end
  end

  describe DodgeParryBlock do
    it "should subclass Wowr::Armory::Character::Stat::DodgeParryBlock" do
      DodgeParryBlock.superclass.should equal(Wowr::Armory::Character::Stat::DodgeParryBlock)
    end
  end

  describe Resilience do
    it "should subclass Wowr::Armory::Character::Stat::Resilience" do
      Resilience.superclass.should equal(Wowr::Armory::Character::Stat::Resilience)
    end
  end

  describe Resistance do
    it "should subclass Wowr::Armory::Character::Stat::Resistance" do
      Resistance.superclass.should equal(Wowr::Armory::Character::Stat::Resistance)
    end
  end

  describe TalentSpec do
    it "should subclass Wowr::Armory::Character::TalentSpec" do
      TalentSpec.superclass.should equal(Wowr::Armory::Character::TalentSpec)
    end
  end

  describe Pvp do
    it "should subclass Wowr::Armory::Character::Pvp" do
      Pvp.superclass.should equal(Wowr::Armory::Character::Pvp)
    end
  end

  describe EquippedItem do
    it "should subclass Wowr::Armory::Character::EquippedItem" do
      EquippedItem.superclass.should equal(Wowr::Armory::Character::EquippedItem)
    end
  end

  describe Skill do
    it "should subclass Wowr::Armory::Character::Skill" do
      Skill.superclass.should equal(Wowr::Armory::Character::Skill)
    end
  end

  describe RepFactionCategory do
    it "should subclass Wowr::Armory::Character::RepFactionCategory" do
      RepFactionCategory.superclass.should equal(Wowr::Armory::Character::RepFactionCategory)
    end
  end

  describe RepFaction do
    it "should subclass Wowr::Armory::Character::RepFaction" do
      RepFaction.superclass.should equal(Wowr::Armory::Character::RepFaction)
    end
  end

  # Dungeon
  describe Dungeon do
    it "should subclass Wowr::Armory::Dungeon::Dungeon" do
      Dungeon.superclass.should equal(Wowr::Armory::Dungeon::Dungeon)
    end
  end

  describe Boss do
    it "should subclass Wowr::Armory::Character::RepFaction" do
      Boss.superclass.should equal(Wowr::Armory::Dungeon::Boss)
    end
  end

  # Guild
  describe Guild do
    it "should subclass Wowr::Armory::Guild::Base" do
      Guild.superclass.should equal(Wowr::Armory::Guild::Base)
    end
  end

  describe SearchGuild do
    it "should subclass Wowr::Armory::Guild::SearchResult" do
      SearchGuild.superclass.should equal(Wowr::Armory::Guild::SearchResult)
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
    it "should subclass Wowr::Armory::Item::SearchResult" do
      SearchItem.superclass.should equal(Wowr::Armory::Item::SearchResult)
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
