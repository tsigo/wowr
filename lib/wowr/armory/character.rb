$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Character
      autoload :Base,         'character/base'
      autoload :Defenses,     'character/defenses'
      autoload :EquippedItem, 'character/equipped_item'
      autoload :Faction,      'character/faction'
      autoload :Full,         'character/full'
      autoload :Info,         'character/info'
      autoload :Pvp,          'character/pvp'
      autoload :SecondBar,    'character/second_bar'
      autoload :Skill,        'character/skill'
      autoload :TalentSpec,   'character/talent_spec'
      autoload :Resistance,   'character/resistance'

      module BaseStats
        autoload :Agility,   'character/base_stats/agility'
        autoload :Intellect, 'character/base_stats/intellect'
        autoload :Spirit,    'character/base_stats/spirit'
        autoload :Stamina,   'character/base_stats/stamina'
        autoload :Strength,  'character/base_stats/strength'
      end

      module DefenseStats
        autoload :Armor,      'character/defense_stats/armor'
        autoload :Avoidance,  'character/defense_stats/avoidance'
        autoload :Defense,    'character/defense_stats/defense'
        autoload :Resilience, 'character/defense_stats/resilience'
      end

      module Spell
        autoload :Damage,    'character/spell/damage'
        autoload :ManaRegen, 'character/spell/mana_regen'
        autoload :Speed,     'character/spell/speed'
        autoload :Spell,     'character/spell/spell'
      end

      module Stat
      end

      module Weapon
        autoload :CritChance, 'character/weapon/crit_chance'
        autoload :Damage,     'character/weapon/damage'
        autoload :Expertise,  'character/weapon/expertise'
        autoload :HitRating,  'character/weapon/hit_rating'
        autoload :Melee,      'character/weapon/melee'
        autoload :PetBonus,   'character/weapon/pet_bonus'
        autoload :Power,      'character/weapon/power'
        autoload :Ranged,     'character/weapon/ranged'
        autoload :Skill,      'character/weapon/skill'
        autoload :Speed,      'character/weapon/speed'
      end
    end
  end
end
