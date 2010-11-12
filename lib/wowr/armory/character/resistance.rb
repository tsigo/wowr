module Wowr
  module Armory
    module Character
      # = Resistance
      #
      # Represents one of the elements in the <tt>resistances</tt> element
      #
      # == Relevant XML examples:
      #
      #   <arcane petBonus="0" value="0"/>
      #
      #   <fire petBonus="0" value="0"/>
      #
      #   <frost petBonus="0" value="0"/>
      #
      #   <holy petBonus="0" value="0"/>
      #
      #   <nature petBonus="0" value="0"/>
      #
      #   <shadow petBonus="0" value="0"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Sebudai
      class Resistance
        # @return [Integer]
        attr_reader :value

        # @return [Integer]
        attr_reader :pet_bonus

        # @param [Nokogiri::XML::Element] elem An element under <tt>resistances</tt>
        def initialize(elem)
          @value      = elem[:value].to_i
          @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
        end
      end
    end
  end
end
