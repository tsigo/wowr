module Wowr
  module Armory
    module Character
      # = Skill
      #
      # Represents a <tt>skill</tt> element
      #
      # == Relevant XML examples:
      #
      #   <skill id="202" key="engineering" max="450" name="Engineering" value="450"/>
      #
      #   <skill id="755" key="jewelcrafting" max="450" name="Jewelcrafting" value="450"/>
      #
      #   <skill id="185" key="cooking" max="450" name="Cooking" value="450"/>
      #
      #   <skill id="129" key="firstaid" max="450" name="First Aid" value="450"/>
      #
      #   <skill id="356" key="fishing" max="375" name="Fishing" value="302"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Alephone
      # * http://www.wowarmory.com/character-sheet.xml?r=Mal'Ganis&cn=Sebudai
      class Skill
        # @example
        #   "enchanting"
        #   "firstaid"
        # @return [String]
        attr_reader :key

        # @example
        #   "Enchanting"
        #   "First Aid"
        # @return [String]
        attr_reader :name

        # Current skill level
        # @return [Integer]
        attr_reader :value

        # Maximum skill level
        # @return [Integer]
        attr_reader :max

        alias_method :to_s, :name
        alias_method :to_i, :value

        # @param [Nokogiri::XML::Element] elem <tt>skill</tt> element
        def initialize(elem)
          @key    = elem[:key]
          @name   = elem[:name]
          @value  = elem[:value].to_i
          @max    = elem[:max].to_i
        end
      end
    end
  end
end
