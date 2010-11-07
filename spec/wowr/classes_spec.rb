require 'spec_helper'

module Wowr::Classes
  describe "Achievement" do
    it { CharacterAchievementsInfo.should             superclass(Wowr::Armory::Achievement::CharacterInfo) }
    it { Achievement.should                           superclass(Wowr::Armory::Achievement::Base) }
    it { CompletedAchievement.should                  superclass(Wowr::Armory::Achievement::Completed) }
    it { AchievementsCategory.should                  superclass(Wowr::Armory::Achievement::Category) }
    it { AchievementsCategoryDetails.should           superclass(Wowr::Armory::Achievement::CategoryDetail) }
    it { AchievementsCategoryDetailsWithPoints.should superclass(Wowr::Armory::Achievement::CategoryDetailWithPoints) }
    it { AchievementsList.should                      superclass(Wowr::Armory::Achievement::List) }
  end

  describe "ArenaTeam" do
    it { ArenaTeam.should       superclass(Wowr::Armory::ArenaTeam::Base) }
    it { SearchArenaTeam.should superclass(Wowr::Armory::ArenaTeam::Search) }
    it { FullArenaTeam.should   superclass(Wowr::Armory::ArenaTeam::Full) }
    it { ArenaTeamEmblem.should superclass(Wowr::Armory::ArenaTeam::Emblem) }
  end

  describe "Calendar" do
    it { pending("Calendar module") }
  end

  describe "Character" do
    it { Character.should          superclass(Wowr::Armory::Character::Base) }
    it { SearchCharacter.should    superclass(Wowr::Armory::Character::Base) }
    it { InfoCharacter.should      superclass(Wowr::Armory::Character::Info) }
    it { FullCharacter.should      superclass(Wowr::Armory::Character::Full) }
    it { SecondBar.should          superclass(Wowr::Armory::Character::SecondBar) }
    it { TalentSpec.should         superclass(Wowr::Armory::Character::TalentSpec) }
    it { Pvp.should                superclass(Wowr::Armory::Character::Pvp) }
    it { EquippedItem.should       superclass(Wowr::Armory::Character::EquippedItem) }
    it { Skill.should              superclass(Wowr::Armory::Character::Skill) }
    it { RepFactionCategory.should superclass(Wowr::Armory::Character::RepFactionCategory) }
    it { RepFaction.should         superclass(Wowr::Armory::Character::RepFaction) }

    describe "BaseStats" do
      it { Agility.should   superclass(Wowr::Armory::Character::BaseStats::Agility) }
      it { Intellect.should superclass(Wowr::Armory::Character::BaseStats::Intellect) }
      it { Spirit.should    superclass(Wowr::Armory::Character::BaseStats::Spirit) }
      it { Stamina.should   superclass(Wowr::Armory::Character::BaseStats::Stamina) }
      it { Strength.should  superclass(Wowr::Armory::Character::BaseStats::Strength) }
    end

    describe "Spell" do
      it { ManaRegen.should   superclass(Wowr::Armory::Character::Spell::ManaRegen) }
      it { Spell.should       superclass(Wowr::Armory::Character::Spell::Spell) }
      it { SpellDamage.should superclass(Wowr::Armory::Character::Spell::Damage) }
      it { SpellSpeed.should  superclass(Wowr::Armory::Character::Spell::Speed) }
    end

    describe "Stat" do
      it { Armor.should           superclass(Wowr::Armory::Character::Stat::Armor) }
      it { Defense.should         superclass(Wowr::Armory::Character::Stat::Defense) }
      it { Defenses.should        superclass(Wowr::Armory::Character::Stat::Defenses) }
      it { DodgeParryBlock.should superclass(Wowr::Armory::Character::Stat::DodgeParryBlock) }
      it { Resilience.should      superclass(Wowr::Armory::Character::Stat::Resilience) }
      it { Resistance.should      superclass(Wowr::Armory::Character::Stat::Resistance) }
    end

    describe "Weapon" do
      it { Melee.should            superclass(Wowr::Armory::Character::Weapon::Melee) }
      it { Ranged.should           superclass(Wowr::Armory::Character::Weapon::Ranged) }
      it { WeaponSkill.should      superclass(Wowr::Armory::Character::Weapon::Skill) }
      it { WeaponDamage.should     superclass(Wowr::Armory::Character::Weapon::Damage) }
      it { WeaponSpeed.should      superclass(Wowr::Armory::Character::Weapon::Speed) }
      it { WeaponPower.should      superclass(Wowr::Armory::Character::Weapon::Power) }
      it { WeaponHitRating.should  superclass(Wowr::Armory::Character::Weapon::HitRating) }
      it { WeaponCritChance.should superclass(Wowr::Armory::Character::Weapon::CritChance) }
      it { WeaponExpertise.should  superclass(Wowr::Armory::Character::Weapon::Expertise) }
      it { PetBonus.should         superclass(Wowr::Armory::Character::Weapon::PetBonus) }
    end
  end

  describe "Dungeon" do
    it { Boss.should    superclass(Wowr::Armory::Dungeon::Boss) }
    it { Dungeon.should superclass(Wowr::Armory::Dungeon::Dungeon) }
  end

  describe "Guild" do
    it { Guild.should       superclass(Wowr::Armory::Guild::Base) }
    it { SearchGuild.should superclass(Wowr::Armory::Guild::SearchResult) }
    it { FullGuild.should   superclass(Wowr::Armory::Guild::Full) }
  end

  describe "GuildBank" do
    it { GuildBank.should         superclass(Wowr::Armory::GuildBank::Base) }
    it { GuildBankContents.should superclass(Wowr::Armory::GuildBank::Contents) }
    it { GuildBankLog.should      superclass(Wowr::Armory::GuildBank::Log) }
    it { GuildBankBag.should      superclass(Wowr::Armory::GuildBank::Bag) }
    it { GuildBankLogEntry.should superclass(Wowr::Armory::GuildBank::LogEntry) }
    it { GuildBankLogItem.should  superclass(Wowr::Armory::GuildBank::LogItem) }
    it { GuildBankItem.should     superclass(Wowr::Armory::GuildBank::Item) }
  end

  describe "Item" do
    it { Item.should             superclass(Wowr::Armory::Item::Base) }
    it { FullItem.should         superclass(Wowr::Armory::Item::Full) }
    it { ItemInfo.should         superclass(Wowr::Armory::Item::Info) }
    it { ItemTooltip.should      superclass(Wowr::Armory::Item::Tooltip) }
    it { SearchItem.should       superclass(Wowr::Armory::Item::SearchResult) }
    it { DisenchantItem.should   superclass(Wowr::Armory::Item::Disenchant) }
    it { CreatedItem.should      superclass(Wowr::Armory::Item::Created) }
    it { PlanItem.should         superclass(Wowr::Armory::Item::Plan) }
    it { Reagent.should          superclass(Wowr::Armory::Item::Reagent) }
    it { ItemEquipData.should    superclass(Wowr::Armory::Item::EquipData) }
    it { ItemSetData.should      superclass(Wowr::Armory::Item::SetData) }
    it { ItemSetBonus.should     superclass(Wowr::Armory::Item::SetBonus) }
    it { ItemSpell.should        superclass(Wowr::Armory::Item::Spell) }
    it { ItemDamageData.should   superclass(Wowr::Armory::Item::DamageData) }
    it { ItemSource.should       superclass(Wowr::Armory::Item::Source) }
    it { ItemQuest.should        superclass(Wowr::Armory::Item::Quest) }
    it { ItemDropCreature.should superclass(Wowr::Armory::Item::DropCreature) }
    it { ItemCost.should         superclass(Wowr::Armory::Item::Cost) }
    it { ItemCostToken.should    superclass(Wowr::Armory::Item::CostToken) }
    it { ItemVendor.should       superclass(Wowr::Armory::Item::Vendor) }
    it { ItemCreation.should     superclass(Wowr::Armory::Item::Creation) }
    it { ItemPlansFor.should     superclass(Wowr::Armory::Item::PlansFor) }
    it { ItemCreatedBy.should    superclass(Wowr::Armory::Item::CreatedBy) }
  end
end
