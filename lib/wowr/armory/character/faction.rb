module Wowr
  module Armory
    module Character
      # = Faction
      #
      # Represents a <tt>faction</tt> element
      #
      # == Relevant XML example:
      #
      #   <faction id="1064" key="thetaunka" name="The Taunka" reputation="42999"/>
      class Faction
        # @return [Integer]
        attr_reader :id

        # @example
        #   "thetaunka"
        # @return [String]
        attr_reader :key

        # @example
        #   "The Taunka"
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :reputation

        # Only present for headers (faction categories)
        # @return [Integer]
        attr_reader :header

        # @param [Hpricot::Elem] elem <tt>faction</tt> element
        def initialize(elem)
          @id         = elem[:id].to_i
          @key        = elem[:key]
          @name       = elem[:name]
          @reputation = elem[:reputation].to_i
          @header     = elem[:header].to_i unless elem[:header].nil?
        end

        # Checks if the element is a faction header
        # @return [Boolean]
        def header?
          @header == 1
        end
      end
    end
  end
end
