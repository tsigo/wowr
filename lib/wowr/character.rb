$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'wowr/item.rb'

require 'armory/character/base'
require 'armory/character/info'

module Wowr
  module Classes
    class Character < Wowr::Armory::Character::Base
    end

    class SearchCharacter < Character
    end

    class InfoCharacter < Wowr::Armory::Character::Info
    end

    # Full character details with reputations
    class FullCharacter < InfoCharacter
      attr_reader :reputation_categories

      alias_method :rep, :reputation_categories
      alias_method :reputation, :reputation_categories

      def initialize(sheet, reputation, talents, api = nil)
        @api = api

        # Build the InfoCharacter
        super(sheet, talents, api)

        # Add reputations
        character_reputation(reputation)
      end

      # character-reputation.xml
      def character_reputation(elem)
        @reputation_categories = {}
        (elem/:factionCategory).each do |category|
          @reputation_categories[category[:key]] = RepFactionCategory.new(category)
        end
      end
    end


    # Second stat bar, depends on character class
    class SecondBar
      attr_reader :effective, :casting, :not_casting, :type

      def initialize(elem)
        @effective    = elem[:effective].to_i
        @casting      = elem[:casting].to_i == -1 ? nil : elem[:casting].to_i
        @not_casting  = elem[:notCasting].to_i == -1 ? nil : elem[:notCasting].to_i
        @type         = elem[:type]
      end
    end


    class BaseStat  # abstract?
      attr_reader :base, :effective
    end

    class Strength < BaseStat
      attr_reader :attack, :block
      def initialize(elem)
        @base       = elem['base'].to_i
        @effective  = elem['effective'].to_i
        @attack     = elem['attack'].to_i
        @block      = elem['block'].to_i == -1 ? nil : elem['block'].to_i
      end
    end

    class Agility < BaseStat
      attr_reader :armor, :attack, :crit_hit_percent
      def initialize(elem)
        @base             = elem[:base].to_i
        @effective        = elem[:effective].to_i
        @armor            = elem[:armor].to_i
        @attack           = elem[:attack].to_i == -1 ? nil : elem[:attack].to_i
        @crit_hit_percent = elem[:critHitPercent].to_f
      end
    end

    class Stamina < BaseStat
      attr_reader :health, :pet_bonus
      def initialize(elem)
        @base       = elem[:base].to_i
        @effective  = elem[:effective].to_i
        @health     = elem[:health].to_i
        @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
      end
    end

    class Intellect < BaseStat
      attr_reader :mana, :crit_hit_percent, :pet_bonus
      def initialize(elem)
        @base             = elem[:base].to_i
        @effective        = elem[:effective].to_i
        @mana             = elem[:mana].to_i
        @crit_hit_percent = elem[:critHitPercent].to_f
        @pet_bonus        = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
      end
    end

    class Spirit < BaseStat
      attr_reader :health_regen, :mana_regen
      def initialize(elem)
        @base         = elem[:base].to_i
        @effective    = elem[:effective].to_i
        @health_regen = elem[:healthRegen].to_i
        @mana_regen   = elem[:manaRegen].to_i
      end
    end

    class Armor < BaseStat
      attr_reader :percent, :pet_bonus
      def initialize(elem)
        @base       = elem[:base].to_i
        @effective  = elem[:effective].to_i
        @percent    = elem[:percent].to_f
        @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
      end
    end



    # <melee>
    #   <mainHandDamage dps="65.6" max="149" min="60" percent="0" speed="1.60"/>
    #   <offHandDamage dps="0.0" max="0" min="0" percent="0" speed="2.00"/>
    #   <mainHandSpeed hastePercent="0.00" hasteRating="0" value="1.60"/>
    #   <offHandSpeed hastePercent="0.00" hasteRating="0" value="2.00"/>
    #   <power base="338" effective="338" increasedDps="24.0"/>
    #   <hitRating increasedHitPercent="0.00" value="0"/>
    #   <critChance percent="4.16" plusPercent="0.00" rating="0"/>
    #   <expertise additional="0" percent="0.00" rating="0" value="0"/>
    # </melee>
    class Melee
      attr_reader :main_hand_skill, :off_hand_skill,
                  :main_hand_damage, :off_hand_damage,
                  :main_hand_speed, :off_hand_speed,
                  :power, :hit_rating, :crit_chance,
                  :expertise

      def initialize(elem)
        # TODO: Do these not exist anymore?
        @main_hand_skill  = WeaponSkill.new(elem%'mainHandWeaponSkill') if (elem%'mainHandWeaponSkill')
        @off_hand_skill   = WeaponSkill.new(elem%'offHandWeaponSkill') if (elem%'offHandWeaponSkill')

        @main_hand_damage = WeaponDamage.new(elem%'mainHandDamage')
        @off_hand_damage  = WeaponDamage.new(elem%'offHandDamage')

        @main_hand_speed  = WeaponSpeed.new(elem%'mainHandSpeed')
        @off_hand_speed   = WeaponSpeed.new(elem%'offHandSpeed')

        @power            = WeaponPower.new(elem%'power')
        @hit_rating       = WeaponHitRating.new(elem%'hitRating')
        @crit_chance      = WeaponCritChance.new(elem%'critChance')

        @expertise        = WeaponExpertise.new(elem%'expertise')
      end
    end

    # <ranged>
    #   <weaponSkill rating="0" value="-1"/>
    #   <damage dps="0.0" max="0" min="0" percent="0" speed="0.00"/>
    #   <speed hastePercent="0.00" hasteRating="0" value="0.00"/>
    #   <power base="57" effective="57" increasedDps="4.0" petAttack="-1.00" petSpell="-1.00"/>
    #   <hitRating increasedHitPercent="0.00" value="0"/>
    #   <critChance percent="0.92" plusPercent="0.00" rating="0"/>
    # </ranged>
    class Ranged
      attr_reader :weapon_skill, :damage, :speed, :power,
                  :hit_rating, :crit_chance

      def initialize(elem)
        @weapon_skill = WeaponSkill.new(elem%'weaponSkill')
        @damage       = WeaponDamage.new(elem%'damage')
        @speed        = WeaponSpeed.new(elem%'speed')
        @power        = WeaponPower.new(elem%'power')
        @hit_rating   = WeaponHitRating.new(elem%'hitRating')
        @crit_chance  = WeaponCritChance.new(elem%'critChance')
      end
    end

    class WeaponSkill
      attr_reader :rating, :value

      def initialize(elem)
        @value  = elem[:value].to_i == -1 ? nil : elem[:value].to_i
        @rating = elem[:rating].to_i
      end
    end

    class WeaponDamage
      attr_reader :dps, :max, :min, :percent, :speed

      def initialize(elem)
        @dps      = elem[:dps].to_f
        @max      = elem[:max].to_i
        @min      = elem[:min].to_i
        @percent  = elem[:percent].to_f
        @speed  = elem[:speed].to_f
      end
    end

    class WeaponSpeed
      attr_reader :haste_percent, :haste_rating, :value

      def initialize(elem)
        @haste_percent  = elem[:hastePercent].to_f
        @haste_rating   = elem[:hasteRating].to_f
        @value        = elem[:value].to_f
      end
    end

    class WeaponPower
      attr_reader :base, :effective, :increased_dps, :pet_attack, :pet_spell, :haste_rating

      def initialize(elem)
        @base           = elem[:base].to_i
        @haste_rating   = elem[:effective].to_i
        @increased_dps  = elem[:increasedDps].to_f
        @pet_attack     = (elem[:petAttack].to_f == -1 ? nil : elem[:petAttack].to_f)
        @pet_spell      = (elem[:petSpell].to_f == -1 ? nil : elem[:petSpell].to_f)
      end
    end

    class WeaponHitRating
      attr_reader :increased_hit_percent, :value, :armor_penetration

      def initialize(elem)
        @armor_penetration = elem[:penetration].to_f
        @increased_hit_percent  = elem[:increasedHitPercent].to_f
        @value                  = elem[:value].to_f
      end
    end

    class WeaponCritChance
      attr_reader :percent, :plus_percent, :rating

      def initialize(elem)
        @percent      = elem[:percent].to_f
        @plus_percent = elem[:plusPercent].to_f
        @rating       = elem[:rating].to_i
      end
    end

    # <expertise additional="0" percent="0.00" rating="0" value="0"/>
    class WeaponExpertise
      attr_reader :additional, :percent, :rating, :value

      def initialize(elem)
        @additional = elem[:additional].to_i
        @percent    = elem[:percent].to_f
        @rating     = elem[:rating].to_i
        @value      = elem[:value].to_i
      end
    end


    # Decided to do funky stuff to the XML to make it more useful.
    # instead of having two seperate lists of bonusDamage and critChance
    # merged it into one set of objects for each thing
    class Spell
      attr_reader :arcane, :fire, :frost, :holy, :nature, :shadow,
                  :hit_rating, :bonus_healing, :penetration, :mana_regen, :speed

      def initialize(elem)
        @arcane = SpellDamage.new(elem%'bonusDamage'%'arcane', elem%'critChance'%'arcane')
        @fire   = SpellDamage.new(elem%'bonusDamage'%'fire', elem%'critChance'%'fire')
        @frost  = SpellDamage.new(elem%'bonusDamage'%'frost', elem%'critChance'%'frost')
        @holy   = SpellDamage.new(elem%'bonusDamage'%'holy', elem%'critChance'%'holy')
        @nature = SpellDamage.new(elem%'bonusDamage'%'nature', elem%'critChance'%'nature')
        @shadow = SpellDamage.new(elem%'bonusDamage'%'shadow', elem%'critChance'%'shadow')

        @bonus_healing  = (elem%'bonusHealing')[:value].to_i # is this right??
        @penetration    = (elem%'penetration')[:value].to_i
        @hit_rating     = WeaponHitRating.new(elem%'hitRating')
        @mana_regen     = ManaRegen.new(elem%'manaRegen')
        @speed      = SpellSpeed.new(elem%'hasteRating')

        # elements = %w[arcane fire frost holy nature shadow]
        # elements.each do |element|
        #   # TODO: is this a good idea?
        #   #instance_variable_set("@#{element}", foo) #??
        #   #eval("@#{element} = SpellDamage.new(elem[:bonusDamage][element][:value], elem[:critChance][element][:percent]).to_f)")
        #   # eval("@#{element} = SpellDamage.new((elem%'bonusDamage'%element)[:value].to_i,
        #   #                                             (elem%'critChance'%element)[:percent].to_f)")
        # end
      end
    end

    class SpellSpeed
      attr_reader :percent_increase, :haste_rating

      def initialize(elem)
        @percent_increase = elem[:hastePercent].to_f
        @haste_rating   = elem[:hasteRating].to_i
      end
    end

    class SpellDamage
      attr_reader :value, :crit_chance_percent
      alias_method :percent, :crit_chance_percent

      def initialize(bonusDamage_elem, critChance_elem)
        @value    = bonusDamage_elem[:value].to_i
        @crit_chance_percent  = critChance_elem[:percent].to_f
      end
    end

    class ManaRegen
      attr_reader :casting, :not_casting

      def initialize(elem)
        @casting      = elem[:casting].to_f
        @not_casting  = elem[:notCasting].to_f
      end
    end

    class PetBonus
      attr_reader :attack, :damage, :from_Type

      def initialize(elem)
        @attack     = elem[:attack].to_i == -1 ? nil : elem[:attack].to_i
        @damage     = elem[:damage].to_i == -1 ? nil : elem[:damage].to_i
        @from_type  = elem[:fromType] if elem[:fromType]
      end
    end



    class Defenses
      attr_reader :armor, :defense, :dodge, :parry, :block, :resilience

      def initialize(elem)
        @armor      = Armor.new(elem%'armor')
        @defense    = Defense.new(elem%'defense')
        @dodge      = DodgeParryBlock.new(elem%'dodge')
        @parry      = DodgeParryBlock.new(elem%'parry')
        @block      = DodgeParryBlock.new(elem%'block')
        @resilience = Resilience.new(elem%'resilience')
      end
    end

    class Armor
      attr_reader :base, :effective, :percent, :pet_bonus

      def initialize(elem)
        @base       = elem[:base].to_i
        @effective  = elem[:effective].to_i
        @percent    = elem[:percent].to_f
        @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
      end
    end

    class Defense
      attr_reader :value, :increase_percent, :decrease_percent, :plus_defense, :rating

      def initialize(elem)
        @value            = elem[:value].to_i
        @increase_percent = elem[:increasePercent].to_f
        @decrease_percent = elem[:decreasePercent].to_f
        @plus_defense     = elem[:plusDefense].to_i
        @rating           = elem[:rating].to_i
      end
    end

    class DodgeParryBlock
      attr_reader :percent, :increase_percent, :rating

      def initialize(elem)
        @percent          = elem[:percent].to_f
        @increase_percent = elem[:increasePercent].to_f
        @rating           = elem[:rating].to_i
      end
    end

    class Resilience
      attr_reader :damage_percent, :hit_percent, :value

      def initialize(elem)
        @damage_percent = elem[:damagePercent].to_f
        @hit_percent    = elem[:hitPercent].to_f
        @value          = elem[:value].to_f
      end
    end


    class Resistance
      attr_reader :value, :pet_bonus

      def initialize(elem)
        @value      = elem[:value].to_i
        @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
      end
    end


    # Note the list of talent trees starts at 1. This is quirky, but that's what's used in the XML
    class TalentSpec
      attr_reader :trees, :active, :group, :primary, :point_distribution

      def initialize(elem)
        tree_elem = elem%'talentSpec'
        @trees = []
        @trees[0] = tree_elem[:treeOne].to_i
        @trees[1] = tree_elem[:treeTwo].to_i
        @trees[2] = tree_elem[:treeThree].to_i
        @active = (elem[:active].to_i == 1 ? true : false)
        @group = elem[:group].to_i
        @primary = elem[:prim]
        @point_distribution = tree_elem[:value]
      end
    end


    # Player-versus-player data
    class Pvp
      attr_reader :lifetime_honorable_kills, :arena_currency

      def initialize(elem)
        @lifetime_honorable_kills = (elem%'lifetimehonorablekills')[:value].to_i
        @arena_currency           = (elem%'arenacurrency')[:value].to_i
      end
    end


    # A buff
    # TODO: Code duplication, see basic Item class. Make extend Icon class?
    class Buff
      attr_reader :name, :effect, :icon_base
      alias_method :to_s, :name

      @@icon_url_base = 'images/icons/'
      @@icon_sizes = {:large => ['64x64', 'jpg'], :medium => ['43x43', 'png'], :small => ['21x21', 'png']}

      def initialize(elem, api = nil)
        @api = api

        @name       = elem[:name]
        @effect     = elem[:effect]
        @icon_base  = elem[:icon]
      end

      # http://armory.worldofwarcraft.com/images/icons/21x21/spell_holy_arcaneintellect.png
      def icon(size = :medium)
        if !@@icon_sizes.include?(size)
          raise Wowr::Exceptions::InvalidIconSize.new(@@icon_sizes)
        end

        if @api
          base = @api.base_url
        else
          base = 'http://www.wowarmory.com/'
        end

        # http://www.wowarmory.com/images/icons/64x64/blahblah.jpg
        return base + @@icon_url_base + @@icon_sizes[size][0] + '/' + @icon_base + '.' + @@icon_sizes[size][1]
      end
    end


    # An item equipped to a player
    class EquippedItem < Item
      attr_reader :durability, :max_durability, #:id, :item_id, :icon,
                  :gems, :permanent_enchant,
                  :random_properties_id, :seed, :slot

      def initialize(elem, api = nil)
        super(elem, api)
        @durability           = elem[:durability].to_i
        @max_durability       = elem[:maxDurability].to_i
        @gems = []
        @gems[0]              = elem[:gem0Id].to_i == 0 ? nil : elem[:gem0Id].to_i
        @gems[1]              = elem[:gem1Id].to_i == 0 ? nil : elem[:gem1Id].to_i
        @gems[2]              = elem[:gem2Id].to_i == 0 ? nil : elem[:gem2Id].to_i
        @permanent_enchant    = elem[:permanentenchant].to_i
        @random_properties_id = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
        @seed                 = elem[:seed].to_i # not sure if seed is so big it's overloading
        @slot                 = elem[:slot].to_i
      end
    end


    # eg Daggers, Riding, Fishing, language
    class Skill
      attr_reader :key, :name, :value, :max
      alias_method :to_s, :name
      alias_method :to_i, :value

      def initialize(elem)
        @key    = elem[:key]
        @name   = elem[:name]
        @value  = elem[:value].to_i
        @max    = elem[:max].to_i
      end
    end


    # Larger group of factions
    # Used for faction information
    # eg Alliance, Shattrath City, Steamwheedle Cartel
    class RepFactionCategory
      attr_reader :key, :name, :factions
      alias_method :to_s, :name

      def initialize(elem)
        @key  = elem[:key]
        @name = elem[:name]

        @factions = {}
        (elem/:faction).each do |faction|
          @factions[faction[:key]] = RepFaction.new(faction)
        end
      end

      def total
        total = 0
        factions.each_value { |faction| total += faction.reputation }
        return total
      end
    end


    # Smaller NPC faction that is part of a FactionCategory
    # eg Darnassus, Argent Dawn
    class RepFaction
      attr_reader :key, :name, :reputation
      alias_method :to_s, :name
      alias_method :to_i, :reputation

      alias_method :rep, :reputation

      def initialize(elem)
        @key        = elem[:key]
        @name       = elem[:name]
        @reputation = elem[:reputation].to_i
      end
    end

  end
end
