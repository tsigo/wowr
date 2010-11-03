$:.unshift(File.dirname(__FILE__))

require 'money'

# Achievements
require 'armory/achievement/base'
require 'armory/achievement/character_info'
require 'armory/achievement/completed'
require 'armory/achievement/category'
require 'armory/achievement/list'

# Achievements
require 'armory/achievement/base'
require 'armory/achievement/character_info'
require 'armory/achievement/completed'
require 'armory/achievement/category'
require 'armory/achievement/list'

# Arena Team
require 'armory/arena_team/base'
require 'armory/arena_team/emblem'
require 'armory/arena_team/full'
require 'armory/arena_team/search'

# Dungeon
require 'armory/dungeon/dungeon'
require 'armory/dungeon/boss'

# Guild
require 'armory/guild/base'
require 'armory/guild/full'
require 'armory/guild/search_result'

# Item
# TODO: Item sources - Vendors
# sourceType.vendor
# sourceType.questReward
# sourceType.createdBySpell
require 'armory/item/base'
require 'armory/item/created'
require 'armory/item/disenchant'
require 'armory/item/full'
require 'armory/item/info'
require 'armory/item/plan'
require 'armory/item/reagent'
require 'armory/item/search_result'
require 'armory/item/tooltip'
require 'armory/item/equip_data'
require 'armory/item/set_data'
require 'armory/item/set_bonus'
require 'armory/item/spell'
require 'armory/item/damage_data'
require 'armory/item/source'
require 'armory/item/quest'
require 'armory/item/drop_creature'
require 'armory/item/cost'
require 'armory/item/cost_token'
require 'armory/item/vendor'
require 'armory/item/creation'
require 'armory/item/plans_for'
require 'armory/item/created_by'

# Guild Bank (Item needs to be required first)
require 'armory/guild_bank/base'
require 'armory/guild_bank/bag'
require 'armory/guild_bank/contents'
require 'armory/guild_bank/item'
require 'armory/guild_bank/log'
require 'armory/guild_bank/log_entry'
require 'armory/guild_bank/log_item'

module Wowr
  module Classes
    # Achievements
    class CharacterAchievementsInfo             < Wowr::Armory::Achievement::CharacterInfo;             end
    class Achievement                           < Wowr::Armory::Achievement::Base;                      end
    class CompletedAchievement                  < Wowr::Armory::Achievement::Completed;                 end
    class AchievementsCategory                  < Wowr::Armory::Achievement::Category;                  end
    class AchievementsCategoryDetails           < Wowr::Armory::Achievement::CategoryDetail;            end
    class AchievementsCategoryDetailsWithPoints < Wowr::Armory::Achievement::CategoryDetailWithPoints;  end
    class AchievementsList                      < Wowr::Armory::Achievement::List;                      end

    # Arena Team
    class ArenaTeam       < Wowr::Armory::ArenaTeam::Base;    end
    class SearchArenaTeam < Wowr::Armory::ArenaTeam::Search;  end
    class FullArenaTeam   < Wowr::Armory::ArenaTeam::Full;    end
    class ArenaTeamEmblem < Wowr::Armory::ArenaTeam::Emblem;  end

    # Dungeon
    class Dungeon   < Wowr::Armory::Dungeon::Dungeon;   end
    class Boss      < Wowr::Armory::Dungeon::Boss;      end

    # Guild
    class Guild       < Wowr::Armory::Guild::Base;         end
    class SearchGuild < Wowr::Armory::Guild::SearchResult; end
    class FullGuild   < Wowr::Armory::Guild::Full;         end

    # Guild Bank
    class GuildBank         < Wowr::Armory::GuildBank::Base;      end
    class GuildBankContents < Wowr::Armory::GuildBank::Contents;  end
    class GuildBankLog      < Wowr::Armory::GuildBank::Log;       end
    class GuildBankBag      < Wowr::Armory::GuildBank::Bag;       end
    class GuildBankLogEntry < Wowr::Armory::GuildBank::LogEntry;  end
    class GuildBankLogItem  < Wowr::Armory::GuildBank::LogItem;   end
    class GuildBankItem     < Wowr::Armory::GuildBank::Item;      end

    # Item
    class Item              < Wowr::Armory::Item::Base;           end
    class FullItem          < Wowr::Armory::Item::Full;           end
    class ItemInfo          < Wowr::Armory::Item::Info;           end
    class ItemTooltip       < Wowr::Armory::Item::Tooltip;        end
    class SearchItem        < Wowr::Armory::Item::SearchResult;   end
    class DisenchantItem    < Wowr::Armory::Item::Disenchant;     end
    class CreatedItem       < Wowr::Armory::Item::Created;        end
    class PlanItem          < Wowr::Armory::Item::Plan;           end
    class Reagent           < Wowr::Armory::Item::Reagent;        end
    class ItemEquipData     < Wowr::Armory::Item::EquipData;      end
    class ItemSetData       < Wowr::Armory::Item::SetData;        end
    class ItemSetBonus      < Wowr::Armory::Item::SetBonus;       end
    class ItemSpell         < Wowr::Armory::Item::Spell;          end
    class ItemDamageData    < Wowr::Armory::Item::DamageData;     end
    class ItemSource        < Wowr::Armory::Item::Source;         end
    class ItemQuest         < Wowr::Armory::Item::Quest;          end
    class ItemDropCreature  < Wowr::Armory::Item::DropCreature;   end
    class ItemCost          < Wowr::Armory::Item::Cost;           end
    class ItemCostToken     < Wowr::Armory::Item::CostToken;      end
    class ItemVendor        < Wowr::Armory::Item::Vendor;         end
    class ItemCreation      < Wowr::Armory::Item::Creation;       end
    class ItemPlansFor      < Wowr::Armory::Item::PlansFor;       end
    class ItemCreatedBy     < Wowr::Armory::Item::CreatedBy;      end
  end
end

# Character - requires Wowr::Classes::Item
require 'armory/character/base'
require 'armory/character/info'
require 'armory/character/full'
require 'armory/character/second_bar'
require 'armory/character/stat/base'
require 'armory/character/stat/strength'
require 'armory/character/stat/agility'
require 'armory/character/stat/stamina'
require 'armory/character/stat/intellect'
require 'armory/character/stat/spirit'
require 'armory/character/stat/armor'
require 'armory/character/weapon/melee'
require 'armory/character/weapon/ranged'
require 'armory/character/weapon/skill'
require 'armory/character/weapon/damage'
require 'armory/character/weapon/speed'
require 'armory/character/weapon/power'
require 'armory/character/weapon/hit_rating'
require 'armory/character/weapon/crit_chance'
require 'armory/character/weapon/expertise'
require 'armory/character/spell/spell'
require 'armory/character/spell/speed'
require 'armory/character/spell/damage'
require 'armory/character/spell/mana_regen'
require 'armory/character/weapon/pet_bonus'
require 'armory/character/stat/defenses'
require 'armory/character/stat/defense'
require 'armory/character/stat/dodge_parry_block'
require 'armory/character/stat/resilience'
require 'armory/character/stat/resistance'
require 'armory/character/talent_spec'
require 'armory/character/pvp'
require 'armory/character/equipped_item'
require 'armory/character/skill'
require 'armory/character/rep_faction_category'
require 'armory/character/rep_faction'

module Wowr
  module Classes
    # Character
    class Character           < Wowr::Armory::Character::Base;                  end
    class SearchCharacter     < Wowr::Armory::Character::Base;                  end
    class InfoCharacter       < Wowr::Armory::Character::Info;                  end
    class FullCharacter       < Wowr::Armory::Character::Full;                  end
    class SecondBar           < Wowr::Armory::Character::SecondBar;             end
    class BaseStat            < Wowr::Armory::Character::Stat::Base;            end
    class Strength            < Wowr::Armory::Character::Stat::Strength;        end
    class Agility             < Wowr::Armory::Character::Stat::Agility;         end
    class Stamina             < Wowr::Armory::Character::Stat::Stamina;         end
    class Intellect           < Wowr::Armory::Character::Stat::Intellect;       end
    class Spirit              < Wowr::Armory::Character::Stat::Spirit;          end
    class Armor               < Wowr::Armory::Character::Stat::Armor;           end
    class Melee               < Wowr::Armory::Character::Weapon::Melee;         end
    class Ranged              < Wowr::Armory::Character::Weapon::Ranged;        end
    class WeaponSkill         < Wowr::Armory::Character::Weapon::Skill;         end
    class WeaponDamage        < Wowr::Armory::Character::Weapon::Damage;        end
    class WeaponSpeed         < Wowr::Armory::Character::Weapon::Speed;         end
    class WeaponPower         < Wowr::Armory::Character::Weapon::Power;         end
    class WeaponHitRating     < Wowr::Armory::Character::Weapon::HitRating;     end
    class WeaponCritChance    < Wowr::Armory::Character::Weapon::CritChance;    end
    class WeaponExpertise     < Wowr::Armory::Character::Weapon::Expertise;     end
    class Spell               < Wowr::Armory::Character::Spell::Spell;          end
    class SpellSpeed          < Wowr::Armory::Character::Spell::Speed;          end
    class SpellDamage         < Wowr::Armory::Character::Spell::Damage;         end
    class ManaRegen           < Wowr::Armory::Character::Spell::ManaRegen;      end
    class PetBonus            < Wowr::Armory::Character::Weapon::PetBonus;      end
    class Defenses            < Wowr::Armory::Character::Stat::Defenses;        end
    class Defense             < Wowr::Armory::Character::Stat::Defense;         end
    class DodgeParryBlock     < Wowr::Armory::Character::Stat::DodgeParryBlock; end
    class Resilience          < Wowr::Armory::Character::Stat::Resilience;      end
    class Resistance          < Wowr::Armory::Character::Stat::Resistance;      end
    class TalentSpec          < Wowr::Armory::Character::TalentSpec;            end
    class Pvp                 < Wowr::Armory::Character::Pvp;                   end
    class EquippedItem        < Wowr::Armory::Character::EquippedItem;          end
    class Skill               < Wowr::Armory::Character::Skill;                 end
    class RepFactionCategory  < Wowr::Armory::Character::RepFactionCategory;    end
    class RepFaction          < Wowr::Armory::Character::RepFaction;            end
  end
end
