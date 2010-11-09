module Wowr
  module Armory
    module Character
      module Weapon
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
          # @return [Damage]
          attr_reader :damage

          # <tt>speed</tt> element
          # @return [Speed]
          attr_reader :speed

          # <tt>power</tt> element
          # @return [Power]
          attr_reader :power

          # <tt>hitRating</tt> element
          # @return [HitRating]
          attr_reader :hit_rating

          # <tt>critChance</tt> element
          # @return [CritChance]
          attr_reader :crit_chance

          # @param [Hpricot::Elem] elem <tt>ranged</tt> element
          def initialize(elem)
            @damage       = Damage.new(elem%'damage')
            @speed        = Speed.new(elem%'speed')
            @power        = Power.new(elem%'power')
            @hit_rating   = HitRating.new(elem%'hitRating')
            @crit_chance  = CritChance.new(elem%'critChance')
          end
        end
      end
    end
  end
end
