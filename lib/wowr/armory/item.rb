$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Item
      autoload :Base,         'item/base'
      autoload :Cost,         'item/cost'
      autoload :CostToken,    'item/cost_token'
      autoload :Created,      'item/created'
      autoload :CreatedBy,    'item/created_by'
      autoload :Creation,     'item/creation'
      autoload :DamageData,   'item/damage_data'
      autoload :Disenchant,   'item/disenchant'
      autoload :DropCreature, 'item/drop_creature'
      autoload :EquipData,    'item/equip_data'
      autoload :Full,         'item/full'
      autoload :Info,         'item/info'
      autoload :Plan,         'item/plan'
      autoload :PlansFor,     'item/plans_for'
      autoload :Quest,        'item/quest'
      autoload :Reagent,      'item/reagent'
      autoload :SearchResult, 'item/search_result'
      autoload :SetBonus,     'item/set_bonus'
      autoload :SetData,      'item/set_data'
      autoload :Source,       'item/source'
      autoload :Spell,        'item/spell'
      autoload :Tooltip,      'item/tooltip'
      autoload :Vendor,       'item/vendor'
    end
  end
end
