$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

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
require 'armory/character/buff'
require 'armory/character/equipped_item'
require 'armory/character/skill'
require 'armory/character/rep_faction_category'
require 'armory/character/rep_faction'

module Wowr
  module Classes
    class Character < Wowr::Armory::Character::Base; end
    class SearchCharacter < Wowr::Armory::Character::Base; end
    class InfoCharacter < Wowr::Armory::Character::Info; end
    class FullCharacter < Wowr::Armory::Character::Full; end
    class SecondBar < Wowr::Armory::Character::SecondBar; end
    class BaseStat < Wowr::Armory::Character::Stat::Base; end
    class Strength < Wowr::Armory::Character::Stat::Strength; end
    class Agility < Wowr::Armory::Character::Stat::Agility; end
    class Stamina < Wowr::Armory::Character::Stat::Stamina; end
    class Intellect < Wowr::Armory::Character::Stat::Intellect; end
    class Spirit < Wowr::Armory::Character::Stat::Spirit; end
    class Armor < Wowr::Armory::Character::Stat::Armor; end
    class Melee < Wowr::Armory::Character::Weapon::Melee; end
    class Ranged < Wowr::Armory::Character::Weapon::Ranged; end
    class WeaponSkill < Wowr::Armory::Character::Weapon::Skill; end
    class WeaponDamage < Wowr::Armory::Character::Weapon::Damage; end
    class WeaponSpeed < Wowr::Armory::Character::Weapon::Speed; end
    class WeaponPower < Wowr::Armory::Character::Weapon::Power; end
    class WeaponHitRating < Wowr::Armory::Character::Weapon::HitRating; end
    class WeaponCritChance < Wowr::Armory::Character::Weapon::CritChance; end
    class WeaponExpertise < Wowr::Armory::Character::Weapon::Expertise; end
    class Spell < Wowr::Armory::Character::Spell::Spell; end
    class SpellSpeed < Wowr::Armory::Character::Spell::Speed; end
    class SpellDamage < Wowr::Armory::Character::Spell::Damage; end
    class ManaRegen < Wowr::Armory::Character::Spell::ManaRegen; end
    class PetBonus < Wowr::Armory::Character::Weapon::PetBonus; end
    class Defenses < Wowr::Armory::Character::Stat::Defenses; end
    class Defense < Wowr::Armory::Character::Stat::Defense; end
    class DodgeParryBlock < Wowr::Armory::Character::Stat::DodgeParryBlock; end
    class Resilience < Wowr::Armory::Character::Stat::Resilience; end
    class Resistance < Wowr::Armory::Character::Stat::Resistance; end
    class TalentSpec < Wowr::Armory::Character::TalentSpec; end
    class Pvp < Wowr::Armory::Character::Pvp; end
    class Buff < Wowr::Armory::Character::Buff; end
    class EquippedItem < Wowr::Armory::Character::EquippedItem; end
    class Skill < Wowr::Armory::Character::Skill; end
    class RepFactionCategory < Wowr::Armory::Character::RepFactionCategory; end
    class RepFaction < Wowr::Armory::Character::RepFaction; end
  end
end
