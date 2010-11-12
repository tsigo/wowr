module Wowr
  module Armory
    module Character
      module SpellStats
        # = Damage
        #
        # Combines <tt>spell/bonusDamage</tt> and <tt>spell/critChance</tt>
        # elements for a single damage type into one representation
        #
        # == Relevant XML examples:
        #
        #   <bonusDamage>
        #     <arcane value="3751"/>
        #     <fire value="3751"/>
        #     <frost value="3751"/>
        #     <holy value="3751"/>
        #     <nature value="3751"/>
        #     <shadow value="3751"/>
        #     <petBonus attack="2138" damage="563" fromType="fire"/>
        #   </bonusDamage>
        #
        #   <critChance rating="530">
        #     <arcane percent="26.34"/>
        #     <fire percent="26.34"/>
        #     <frost percent="26.34"/>
        #     <holy percent="26.34"/>
        #     <nature percent="26.34"/>
        #     <shadow percent="26.34"/>
        #   </critChance>
        class Damage
          # @return [Integer]
          attr_reader :value

          # @return [Float]
          attr_reader :crit_chance_percent

          alias_method :percent, :crit_chance_percent

          # @param [Nokogiri::XML::Element] bonusDamage_elem An element under <tt>spell/bonusDamage</tt>
          # @param [Nokogiri::XML::Element] critChance_elem An element under <tt>spell/critChance</tt>
          def initialize(bonusDamage_elem, critChance_elem)
            @value               = bonusDamage_elem[:value].to_i
            @crit_chance_percent = critChance_elem[:percent].to_f
          end
        end
      end
    end
  end
end
