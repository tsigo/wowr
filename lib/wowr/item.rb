# TODO: Item sources - Vendors
# sourceType.vendor
# sourceType.questReward
# sourceType.createdBySpell

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'general.rb'

require 'armory/item/base'
require 'armory/item/cost'
require 'armory/item/cost_token'
require 'armory/item/created'
require 'armory/item/created_by'
require 'armory/item/creation'
require 'armory/item/damage_data'
require 'armory/item/disenchant'
require 'armory/item/drop_creature'
require 'armory/item/equip_data'
require 'armory/item/full'
require 'armory/item/info'
require 'armory/item/plan'
require 'armory/item/plans_for'
require 'armory/item/quest'
require 'armory/item/reagent'
require 'armory/item/search'
require 'armory/item/set_bonus'
require 'armory/item/set_data'
require 'armory/item/source'
require 'armory/item/spell'
require 'armory/item/tooltip'
require 'armory/item/vendor'

module Wowr
  module Classes
    class Item             < Wowr::Armory::Item::Base; end
    class FullItem         < Wowr::Armory::Item::Full; end
    class ItemInfo         < Wowr::Armory::Item::Info; end
    class ItemTooltip      < Wowr::Armory::Item::Tooltip; end
    class SearchItem       < Wowr::Armory::Item::Search; end
    class DisenchantItem   < Wowr::Armory::Item::Disenchant; end
    class CreatedItem      < Wowr::Armory::Item::Created; end
    class PlanItem         < Wowr::Armory::Item::Plan; end
    class Reagent          < Wowr::Armory::Item::Reagent; end
    class ItemEquipData    < Wowr::Armory::Item::EquipData; end
    class ItemSetData      < Wowr::Armory::Item::SetData; end
    class ItemSetBonus     < Wowr::Armory::Item::SetBonus; end
    class ItemSpell        < Wowr::Armory::Item::Spell; end
    class ItemDamageData   < Wowr::Armory::Item::DamageData; end
    class ItemSource       < Wowr::Armory::Item::Source; end
    class ItemQuest        < Wowr::Armory::Item::Quest; end
    class ItemDropCreature < Wowr::Armory::Item::DropCreature; end
    class ItemCost         < Wowr::Armory::Item::Cost; end
    class ItemCostToken    < Wowr::Armory::Item::CostToken; end
    class ItemVendor       < Wowr::Armory::Item::Vendor; end
    class ItemCreation     < Wowr::Armory::Item::Creation; end
    class ItemPlansFor     < Wowr::Armory::Item::PlansFor; end
    class ItemCreatedBy    < Wowr::Armory::Item::CreatedBy; end
  end
end
