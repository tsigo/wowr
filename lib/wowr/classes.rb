$:.unshift(File.dirname(__FILE__))

require 'general'

# Arena Team
require 'armory/arena_team/base'
require 'armory/arena_team/emblem'
require 'armory/arena_team/full'
require 'armory/arena_team/search'

# Guild
require 'armory/guild/base'
require 'armory/guild/full'
require 'armory/guild/search'

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
require 'armory/item/search'
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
    # Arena Team
    class ArenaTeam       < Wowr::Armory::ArenaTeam::Base;    end
    class SearchArenaTeam < Wowr::Armory::ArenaTeam::Search;  end
    class FullArenaTeam   < Wowr::Armory::ArenaTeam::Full;    end
    class ArenaTeamEmblem < Wowr::Armory::ArenaTeam::Emblem;  end

    # Guild
    class Guild       < Wowr::Armory::Guild::Base;    end
    class SearchGuild < Wowr::Armory::Guild::Search;  end
    class FullGuild   < Wowr::Armory::Guild::Full;    end

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
    class SearchItem        < Wowr::Armory::Item::Search;         end
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
