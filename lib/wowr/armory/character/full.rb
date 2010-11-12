module Wowr
  module Armory
    module Character
      # = Full
      #
      # Represents a full collection of information for a character. Requires
      # information from <tt>character-sheet.xml</tt>,
      # <tt>character-reputation.xml</tt> and <tt>character-talents.xml</tt>
      # pages.
      #
      # @todo Info is only used by this class and never instantiated directly.
      #   Could we just incorporate it here?
      class Full < Info
        # @return [Array] Array of {Faction} instances
        attr_reader :reputation

        alias_method :rep, :reputation

        # @param [Nokogiri::XML::Element] sheet <tt>character-sheet.xml</tt> page
        # @param [Nokogiri::XML::Element] reputation <tt>character-reputation.xml</tt> page
        # @param [Nokogiri::XML::Element] talents <tt>character-talents.xml</tt> page
        # @param [Wowr::API::API] api
        def initialize(sheet, reputation, talents, api = nil)
          @api = api

          # Build the InfoCharacter
          super(sheet, talents, api)

          # Add reputations
          @reputation = []
          (reputation/'faction').each do |faction_elem|
            faction = Faction.new(faction_elem)
            @reputation << faction unless faction.header?
          end
        end

        # @deprecated
        def reputation_categories
          puts "** [DEPRECATED] 'reputation_categories' is deprecated. Use 'reputation' instead."
          reputation
        end
      end
    end
  end
end
