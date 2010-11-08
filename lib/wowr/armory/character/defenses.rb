module Wowr
  module Armory
    module Character
      # = Defenses
      #
      # Represents a <tt>defenses</tt> element group
      #
      # == Relevant XML example:
      #
      #   <defenses>
      #     <armor base="21842" effective="21842" percent="58.91" petBonus="-1"/>
      #     <defense decreasePercent="0.00" increasePercent="0.00" plusDefense="0" rating="0" value="400.00"/>
      #     <dodge increasePercent="0.00" percent="5.82" rating="0"/>
      #     <parry increasePercent="0.11" percent="5.12" rating="5"/>
      #     <block increasePercent="0.00" percent="5.00" rating="0"/>
      #     <resilience damagePercent="0" hitPercent="0" value="0.00"/>
      #   </defenses>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Alephone
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Sebudai
      class Defenses
        # @return [DefenseStats::Armor]
        attr_reader :armor

        # @return [DefenseStats::Defense]
        attr_reader :defense

        # @return [DefenseStats::Avoidance]
        attr_reader :dodge

        # @return [DefenseStats::Avoidance]
        attr_reader :parry

        # @return [DefenseStats::Avoidance]
        attr_reader :block

        # @return [DefenseStats::Resilience]
        attr_reader :resilience

        # @param [Hpricot::Elem] elem <tt>defenses</tt> element
        def initialize(elem)
          @armor      = DefenseStats::Armor.new(elem%'armor')
          @defense    = DefenseStats::Defense.new(elem%'defense')
          @dodge      = DefenseStats::Avoidance.new(elem%'dodge')
          @parry      = DefenseStats::Avoidance.new(elem%'parry')
          @block      = DefenseStats::Avoidance.new(elem%'block')
          @resilience = DefenseStats::Resilience.new(elem%'resilience')
        end
      end
    end
  end
end
