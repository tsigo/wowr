$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Character
      autoload :Base,               'character/base'
      autoload :EquippedItem,       'character/equipped_item'
      autoload :Full,               'character/full'
      autoload :Info,               'character/info'
      autoload :Pvp,                'character/pvp'
      autoload :RepFaction,         'character/rep_faction'
      autoload :RepFactionCategory, 'character/rep_faction_category'
      autoload :SecondBar,          'character/second_bar'
      autoload :Skill,              'character/skill'
      autoload :TalentSpec,         'character/talent_spec'
      autoload :Resistance,         'character/resistance'

      module BaseStats
        autoload :Agility,            'character/base_stats/agility'
        autoload :Intellect,          'character/base_stats/intellect'
        autoload :Spirit,             'character/base_stats/spirit'
        autoload :Stamina,            'character/base_stats/stamina'
        autoload :Strength,           'character/base_stats/strength'
      end

      module Defenses
        autoload :Armor,              'character/defenses/armor'
        autoload :Defense,            'character/defenses/defense'
        autoload :DodgeParryBlock,    'character/defenses/dodge_parry_block'
        autoload :Resilience,         'character/defenses/resilience'
      end

      module Spell
        autoload :Damage,             'character/spell/damage'
        autoload :ManaRegen,          'character/spell/mana_regen'
        autoload :Speed,              'character/spell/speed'
        autoload :Spell,              'character/spell/spell'
      end

      module Stat
        autoload :Defenses,           'character/stat/defenses'
      end

      module Weapon
        autoload :CritChance,         'character/weapon/crit_chance'
        autoload :Damage,             'character/weapon/damage'
        autoload :Expertise,          'character/weapon/expertise'
        autoload :HitRating,          'character/weapon/hit_rating'
        autoload :Melee,              'character/weapon/melee'
        autoload :PetBonus,           'character/weapon/pet_bonus'
        autoload :Power,              'character/weapon/power'
        autoload :Ranged,             'character/weapon/ranged'
        autoload :Skill,              'character/weapon/skill'
        autoload :Speed,              'character/weapon/speed'
      end
    end
  end
end
