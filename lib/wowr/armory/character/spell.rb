module Wowr
  module Armory
    module Character
      # = Spell
      #
      # Represents a <tt>spell</tt> element in <tt>character-sheet.xml</tt>
      #
      # == Relevant XML example:
      #
      #   <spell>
      #     <bonusDamage>
      #       <arcane value="3751"/>
      #       <fire value="3751"/>
      #       <frost value="3751"/>
      #       <holy value="3751"/>
      #       <nature value="3751"/>
      #       <shadow value="3751"/>
      #       <petBonus attack="2138" damage="563" fromType="fire"/>
      #     </bonusDamage>
      #     <bonusHealing value="3571"/>
      #     <hitRating increasedHitPercent="17.00" penetration="0" reducedResist="0" value="446"/>
      #     <critChance rating="530">
      #       <arcane percent="26.34"/>
      #       <fire percent="26.34"/>
      #       <frost percent="26.34"/>
      #       <holy percent="26.34"/>
      #       <nature percent="26.34"/>
      #       <shadow percent="26.34"/>
      #     </critChance>
      #     <penetration value="0"/>
      #     <manaRegen casting="193.00" notCasting="364.00"/>
      #     <hasteRating hastePercent="43.37" hasteRating="1422"/>
      #   </spell>
      class Spell
        # @return [SpellStats::Damage] Arcane damage and crit
        attr_reader :arcane

        # @return [SpellStats::Damage] Fire damage and crit
        attr_reader :fire

        # @return [SpellStats::Damage] Frost damage and crit
        attr_reader :frost

        # @return [SpellStats::Damage] Holy damage and crit
        attr_reader :holy

        # @return [SpellStats::Damage] Nature damage and crit
        attr_reader :nature

        # @return [SpellStats::Damage] Shadow damage and crit
        attr_reader :shadow

        # @return [SpellStats::HitRating]
        attr_reader :hit_rating

        # @return [Integer]
        attr_reader :bonus_healing

        # @return [Integer]
        attr_reader :penetration

        # @return [SpellStats::ManaRegen]
        attr_reader :mana_regen

        # Haste
        # @return [SpellStats::Speed]
        attr_reader :speed

        # @param [Nokogiri::XML::Element] elem <tt>spell</tt> element
        def initialize(elem)
          @arcane = damage_type(elem, :arcane)
          @fire   = damage_type(elem, :fire)
          @frost  = damage_type(elem, :frost)
          @holy   = damage_type(elem, :holy)
          @nature = damage_type(elem, :nature)
          @shadow = damage_type(elem, :shadow)

          @bonus_healing = (elem%'bonusHealing')[:value].to_i
          @penetration   = (elem%'penetration')[:value].to_i
          @hit_rating    = SpellStats::HitRating.new(elem%'hitRating')
          @mana_regen    = SpellStats::ManaRegen.new(elem%'manaRegen')
          @speed         = SpellStats::Speed.new(elem%'hasteRating')
        end

        private

        def damage_type(elem, type)
          SpellStats::Damage.new(elem%'bonusDamage'%type, elem%'critChance'%type)
        end
      end
    end
  end
end
