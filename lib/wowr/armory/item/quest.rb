module Wowr
  module Armory
    module Item
      # Represents a quest which awards an item
      #
      # == Relevant XML Example:
      #
      #   <quest area="Icecrown" id="13219" level="80" name="Battle at Valhalas: Final Challenge" reqMinLevel="77" suggestedPartySize="5" type="Group"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=49623
      # * http://www.wowarmory.com/item-info.xml?i=44382
      # * http://www.wowarmory.com/item-info.xml?i=33230
      #
      # @todo Rename
      # @todo There's no reason for this to be in the Item module - it's just quest data
      class Quest
        # Quest name
        # @return [String]
        attr_reader :name

        # Quest ID
        # @return [Integer]
        attr_reader :id

        # Quest level
        # @return [Integer]
        attr_reader :level

        # Quest minimum level
        # @return [Integer]
        attr_reader :min_level

        # Quest area (zone name)
        # @return [String]
        attr_reader :area

        # Quest suggested party size
        # @return [Integer]
        attr_reader :suggested_party_size

        # @param [Hpricot::Elem] elem <tt>quest</tt> element
        def initialize(elem)
          @name                 = elem[:name]
          @id                   = elem[:id].to_i
          @level                = elem[:level].to_i
          @min_level            = elem[:reqMinLevel].to_i
          @area                 = elem[:area]
          @suggested_party_size = elem[:suggestedPartySize].to_i
        end
      end
    end
  end
end
