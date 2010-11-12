module Wowr
  module Armory
    module Character
      # = Ranged
      #
      # Represents a <tt>ranged</tt> element
      #
      # == Relevant XML example:
      #
      #   <ranged>
      #     <weaponSkill rating="0" value="0"/>
      #     <damage dps="597.4" max="1029" min="554" percent="0" speed="1.33"/>
      #     <speed hastePercent="43.37" hasteRating="1422" value="1.33"/>
      #     <power base="0" effective="0" increasedDps="0.0" petAttack="-1.00" petSpell="-1.00"/>
      #     <hitRating increasedHitPercent="14.50" penetration="0" reducedArmorPercent="0.00" value="446"/>
      #     <critChance percent="15.63" plusPercent="11.55" rating="530"/>
      #   </ranged>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Alephone
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Sebudai
      class Ranged
        # <tt>damage</tt> element
        # @return [WeaponStats::Damage]
        attr_reader :damage

        # <tt>speed</tt> element
        # @return [WeaponStats::Speed]
        attr_reader :speed

        # <tt>power</tt> element
        # @return [WeaponStats::Power]
        attr_reader :power

        # <tt>hitRating</tt> element
        # @return [WeaponStats::HitRating]
        attr_reader :hit_rating

        # <tt>critChance</tt> element
        # @return [WeaponStats::CritChance]
        attr_reader :crit_chance

        # @param [Nokogiri::XML::Element] elem <tt>ranged</tt> element
        def initialize(elem)
          @damage       = WeaponStats::Damage.new(elem%'damage')
          @speed        = WeaponStats::Speed.new(elem%'speed')
          @power        = WeaponStats::Power.new(elem%'power')
          @hit_rating   = WeaponStats::HitRating.new(elem%'hitRating')
          @crit_chance  = WeaponStats::CritChance.new(elem%'critChance')
        end
      end
    end
  end
end
